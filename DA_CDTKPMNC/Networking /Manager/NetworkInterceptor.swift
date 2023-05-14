//
//  NetworkInterceptor.swift
//  DA_CDTKPMNC
//
//  Created by Hoang Son Vo Phuoc on 5/14/23.
//

import Foundation
import Alamofire

class NetworkInterceptor: RequestInterceptor {
    private let token: String
    
    init(token: String) {
        self.token = token
    }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var adaptedRequest = urlRequest
        adaptedRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        completion(.success(adaptedRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
            /// The request did not fail due to a 401 Unauthorized response.
            /// Return the original error and don't retry the request.
            return completion(.doNotRetryWithError(error))
        }
        
        //            refreshToken { [weak self] result in
        //                guard let self = self else { return }
        //
        //                switch result {
        //                case .success(let token):
        //                    self.storage.accessToken = token
        //                    /// After updating the token we can safely retry the original request.
        //                    completion(.retry)
        //                case .failure(let error):
        //                    completion(.doNotRetryWithError(error))
        //                }
        //            }
    }
}
