//
//  NetworkInterceptor.swift
//  DA_CDTKPMNC
//
//  Created by Hoang Son Vo Phuoc on 5/14/23.
//

import Foundation
import Alamofire

class NetworkInterceptor: RequestInterceptor {
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        var adaptedRequest = urlRequest
    
        guard let token = LocalStorageManager.shared.fetchCredential() else {
            completion(.success(adaptedRequest))
            return
        }
        
        adaptedRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        completion(.success(adaptedRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
            /// The request did not fail due to a 401 Unauthorized response.
            /// Return the original error and don't retry the request.
            return completion(.doNotRetryWithError(error))
        }
        
        guard let refreshToken = LocalStorageManager.shared.fetchCurrentUser()?.token?.refreshToken else {
            return
        }
        
        NetworkManager.shared.refreshToken(refreshToken: refreshToken) { [weak self] result in
            
            guard let _ = self else {
                return
            }
            
            switch result {
                
            case .success(let response):
                
                debugPrint("Refresh token called successfully")
                
                LocalStorageManager.shared.updateCredential(response.data?.accessToken ?? "")
                
                LocalStorageManager.shared.updateRefreshToken(response.data?.refreshToken ?? "")
                
                completion(.retry)
                
            case .failure(let error):
                completion(.doNotRetryWithError(error))
            }
        }
    }
}
