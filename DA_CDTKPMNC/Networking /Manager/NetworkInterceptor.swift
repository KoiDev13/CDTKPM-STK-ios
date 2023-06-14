//
//  NetworkInterceptor.swift
//  DA_CDTKPMNC
//
//  Created by Hoang Son Vo Phuoc on 5/14/23.
//

import Foundation
import Moya
import JWTDecode

class TokenManager {
    
    private var accessToken: String
    
    private var refreshToken: String
    
    private var refreshTokenCompletion: ((Result<String, Error>) -> Void)?
    
    private var isRefreshing = false
    
    private let refreshQueue = DispatchQueue(label: "com.example.refreshQueue")
    
    private let group = DispatchGroup()
    
    init(accessToken: String, refreshToken: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
    
    func getAccessToken() -> String {
        return accessToken
    }
    
    func tokenIsExpired() -> Bool {
        do {
            let jwt = try decode(jwt: accessToken)
            
            if let expirationDate = jwt.expiresAt {
                let currentDate = Date()
                let minutesToExpiration = expirationDate.timeIntervalSince(currentDate) / 60
                
                if minutesToExpiration > 0 {
                    print("Token is not expired. Minutes to expiration: \(minutesToExpiration)")
                    return false
                } else {
                    print("Token is expired")
                    return true
                }
            } else {
                print("Invalid token")
                return true
            }
        } catch {
            print("Failed to decode token: \(error)")
            return true
        }
    }

    private func refreshAccessToken(completion: @escaping (Result<String, Error>) -> Void) {
        isRefreshing = true
//        group.enter()

        NetworkManager.shared.refreshToken(refreshToken: refreshToken) { result in
            defer {
                self.isRefreshing = false
//                self.group.leave()
            }

            switch result {
            case .success(let response):
                guard let accessToken = response.data?.accessToken,
                      let refreshToken = response.data?.refreshToken else {
                    completion(.failure(NetworkError.invalidResponse))
                    return
                }

                self.accessToken = accessToken
                self.refreshToken = refreshToken
                LocalStorageManager.shared.updateCredential(accessToken)
                LocalStorageManager.shared.updateRefreshToken(refreshToken)

                self.refreshTokenCompletion?(.success(accessToken))
                self.refreshTokenCompletion = nil

                completion(.success(accessToken))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func refreshTokenIfNeeded(completion: @escaping (Result<Void, Error>) -> Void) {
        if tokenIsExpired() {
            if !isRefreshing {
                refreshAccessToken { result in
                    switch result {
                    case .success:
                        completion(.success(()))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            } else {
                completion(.success(()))
//                group.notify(queue: refreshQueue) {
//                    completion(.success(()))
//                }
            }
        } else {
            completion(.success(()))
        }
    }

    
//    func refreshTokenIfNeeded<T: TargetType>(_ target: T, completion: @escaping (Result<Moya.Response, Error>) -> Void) {
//           // Kiểm tra token đã hết hạn hay chưa
//           if tokenIsExpired() {
//               // Nếu token đã hết hạn, kiểm tra xem có đang thực hiện quá trình refresh token hay không
//               if !isRefreshing {
//                   // Không có quá trình refresh token đang thực hiện, bắt đầu quá trình refresh
//                   refreshAccessToken { result in
//                       switch result {
//                       case .success(let newToken):
//                           // Refresh token thành công, gọi lại API trước đó
//                           self.callAPI(target, completion: completion)
//                       case .failure(let error):
//                           // Refresh token thất bại, gửi lỗi về cho completion
//                           completion(.failure(error))
//                       }
//                   }
//               } else {
//                   // Đang trong quá trình refresh token, block API và đợi refresh token hoàn thành
//                   refreshTokenCompletion = { result in
//                       switch result {
//                       case .success:
//                           // Refresh token thành công, gọi lại API trước đó
//                           self.callAPI(target, completion: completion)
//                       case .failure(let error):
//                           // Refresh token thất bại, gửi lỗi về cho completion
//                           completion(.failure(error))
//                       }
//                   }
//               }
//           } else {
//               // Token còn hạn, gọi API trực tiếp
//               callAPI(target, completion: completion)
//           }
//       }
    
//    private func callAPI<T: TargetType>(_ target: T, completion: @escaping (Result<Moya.Response, Error>) -> Void) {
//        let provider = MoyaProvider<T>()
//        provider.request(target) { result in
//            completion(result)
//        }
//    }
    
    
//    func callAPI<T: Decodable>(
//        target: TargetType,
//        completion: @escaping (Result<T, Error>) -> ()
//    ) {
//        provider.request(target) { result in
//            switch result {
//            case let .success(response):
//                let statusCode = response.statusCode
//                if (200..<300).contains(statusCode) {
//                    do {
//                        let results = try JSONDecoder().decode(T.self, from: response.data)
//                        completion(.success(results))
//                    } catch let error {
//                        completion(.failure(error))
//                    }
//                } else {
//                    do {
//                        let results = try JSONDecoder().decode(APIError.self, from: response.data)
//                        completion(.failure(results))
//                    } catch let error {
//                        completion(.failure(error))
//                    }
//                }
//            case let .failure(error):
//                completion(.failure(error))
//            }
//        }
//    }
}




