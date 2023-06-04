//
//  NetworkInterceptor.swift
//  DA_CDTKPMNC
//
//  Created by Hoang Son Vo Phuoc on 5/14/23.
//

import Foundation
import Alamofire

class TokenInterceptor: RequestInterceptor {
    
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
            // Không phải lỗi 401 Unauthorized, không cần refresh token
            completion(.doNotRetry)
            return
        }
        
        guard let refreshToken = LocalStorageManager.shared.fetchRefreshToken() else {
            print("Refresh token is missing.")
            completion(.doNotRetry)
            return
        }
        
        NetworkManager.shared.refreshToken(refreshToken: refreshToken) { result in
            
            switch result {
            case .success(let response):
                
                guard let accessToken = response.data?.accessToken,
                      let refreshToken = response.data?.refreshToken else {
                    completion(.doNotRetry)
                    return
                }
                
                LocalStorageManager.shared.updateCredential(accessToken)
                
                LocalStorageManager.shared.updateRefreshToken(refreshToken)
                
                completion(.retry)
                
            case .failure:
                completion(.doNotRetry)
            }
        }
    }
}

class TokenManager {
    
    //    private var accessToken: String?
    //
    //    private var refreshToken: String?
    //
    //    func setTokens(accessToken: String?, refreshToken: String?) {
    //        self.accessToken = accessToken
    //        self.refreshToken = refreshToken
    //    }
    
    //
    //    func performAPIRequest() {
    //        if isAccessTokenValid() {
    //            print("Performing API request with access token:", accessToken!)
    //        } else {
    //            refreshAccessToken()
    //        }
    //    }
    //
    //    private func isAccessTokenValid() -> Bool {
    //
    //        guard let accessToken = accessToken,
    //              let jwt = try? decodeJWT(accessToken),
    //              let expirationDate = jwt.expirationDate else {
    //            return false
    //        }
    //
    //        let currentDate = Date()
    //        return currentDate < expirationDate
    //    }
    
    func refreshAccessToken(completion: @escaping (Result<String, Error>) -> Void) {
        guard let refreshToken = LocalStorageManager.shared.fetchRefreshToken() else {
            print("Refresh token is missing.")
            completion(.failure(CustomError.somethingWentWrong))
            return
        }
        
        print("Calling API to refresh token with refresh token:", refreshToken)
        
        NetworkManager.shared.refreshToken(refreshToken: refreshToken) { result in
            
            switch result {
            case .success(let response):
                
                guard let accessToken = response.data?.accessToken,
                      let refreshToken = response.data?.refreshToken else {
                    completion(.failure(CustomError.somethingWentWrong))
                    return
                }
                
                LocalStorageManager.shared.updateCredential(accessToken)
                
                LocalStorageManager.shared.updateRefreshToken(refreshToken)
                
                completion(.success(accessToken))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func decodeJWT(_ token: String) throws -> DecodedJWT {
        let expirationDate = Date(timeIntervalSinceNow: 3600)
        
        return DecodedJWT(expirationDate: expirationDate)
    }
}

// Đây là một cấu trúc đại diện cho thông tin được trích xuất từ JWT.
struct DecodedJWT {
    let expirationDate: Date?
}
