//
//  NetworkInterceptor.swift
//  DA_CDTKPMNC
//
//  Created by Hoang Son Vo Phuoc on 5/14/23.
//

import Foundation
import Moya

class NetworkInterceptor: RequestInterceptor {
    
//    private let logger: NetworkLoggerPlugin
//    
//    init(logger: NetworkLoggerPlugin) {
//        self.logger = logger
//    }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        var adaptedRequest = urlRequest
        
        guard let token = LocalStorageManager.shared.fetchCredential() else {
            completion(.success(adaptedRequest))
            return
        }
        
        adaptedRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        completion(.success(adaptedRequest))
    }
    
//    func intercept(_ request: URLRequest, endpoint: Endpoint, completion: @escaping (Result<URLRequest, Error>) -> Void) {
//        let originalRequest = request
//        
//        // Thực hiện yêu cầu gốc
//        let task = URLSession.shared.dataTask(with: originalRequest) { [weak self] (data, response, error) in
//            if let httpResponse = response as? HTTPURLResponse {
//                let statusCode = httpResponse.statusCode
//                
//                if statusCode == 401 {
//                    // Gọi hàm refresh token và thực hiện yêu cầu lại
//                    self?.refreshToken { [weak self] result in
//                        switch result {
//                        case .success(let newToken):
//                            var updatedRequest = originalRequest
//                            // Cập nhật header yêu cầu với token mới
//                            updatedRequest.setValue(newToken, forHTTPHeaderField: "Authorization")
//                            
//                            // Gọi lại yêu cầu với token mới
//                            completion(.success(updatedRequest))
//                        case .failure(let error):
//                            completion(.failure(error))
//                        }
//                    }
//                } else {
//                    // Xử lý logic khi yêu cầu thành công và không phải là 401
//                    completion(.success(originalRequest))
//                }
//            } else {
//                // Xử lý logic khi không nhận được phản hồi HTTP
//                completion(.failure(CustomError.somethingWentWrong))
//            }
//        }
//        
//        task.resume()
//    }

//    func refreshToken(completion: @escaping (Result<String, Error>) -> Void) {
//        // Thực hiện logic để refresh token
//        // Sau khi refresh token thành công, gọi completion với token mới
//        guard let refreshToken = LocalStorageManager.shared.fetchCurrentUser()?.token?.refreshToken else {
//            completion(.failure(CustomError.somethingWentWrong))
//            return
//        }
//
//        NetworkManager.shared.refreshToken(refreshToken: refreshToken) { result in
//
//
//
//            switch result {
//
//            case .success(let response):
//
//                guard let accessToken = response.data?.accessToken, let refreshToken = response.data?.refreshToken else {
//                    completion(.failure(CustomError.somethingWentWrong))
//                    return
//                }
//
//
//
//                debugPrint("Refresh token called successfully")
//
//                LocalStorageManager.shared.updateCredential(accessToken)
//
//                LocalStorageManager.shared.updateRefreshToken(response.data?.refreshToken ?? "")
//
//                completion(.success(accessToken))
//
//            case .failure(let error):
//                completion(.failure(error))
//            }
//    }

    
//    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
//
//        if let response = request.response, response.statusCode == 401 {
//
//            guard let refreshToken = LocalStorageManager.shared.fetchCurrentUser()?.token?.refreshToken else {
//                completion(.doNotRetry)
//                return
//            }
//
//            NetworkManager.shared.refreshToken(refreshToken: refreshToken) { result in
//
//
//
//                switch result {
//
//                case .success(let response):
//
//                    debugPrint("Refresh token called successfully")
//
//                    LocalStorageManager.shared.updateCredential(response.data?.accessToken ?? "")
//
//                    LocalStorageManager.shared.updateRefreshToken(response.data?.refreshToken ?? "")
//
//                    completion(.retry)
//
//                case .failure(let error):
//                    completion(.doNotRetryWithError(error))
//                }
//            }
//        } else {
//            completion(.doNotRetry)
//        }
//    }
}
