//
//  NetworkManager.swift
//  DA_CDTKPMNC
//
//  Created by Hoang Son Vo Phuoc on 5/7/23.
//

import Foundation
import Moya

final class NetworkManager: APIClientProtocol {
    
    static let shared = NetworkManager()
    
    typealias TargetType = APITarget
    
    private let session: Session
    
    private let tokenManager: TokenManager
    
//    private var targetRequests: [TargetType] = []
//
//    private var targetRequestsCallAgained: [TargetType] = []
//
//    private let apiQueue = DispatchQueue(label: "com.example.api
    
    init() {
        
        session = Session()
        
        let accessToken = LocalStorageManager.shared.fetchCredential() ?? ""
        
        let refreshToken = LocalStorageManager.shared.fetchRefreshToken() ?? ""
        
        tokenManager = TokenManager(accessToken: accessToken, refreshToken: refreshToken)
    }
    
    var provider: MoyaProvider<TargetType> {
        MoyaProvider(
            session: session,
            plugins: [
                NetworkLoggerPlugin.init(
                    configuration: .init(
                        formatter: .init(),
                        logOptions: .formatRequestAscURL
                    )
                )
            ]
        )
    }
    
    
    
//    func request<T: Decodable>(
//        target: TargetType,
//        completion: @escaping (Result<T, Error>) -> Void
//    ) {
//
//        if tokenManager.getAccessToken().isEmpty {
//            provider.request(target) { result in
//                switch result {
//                case let .success(response):
//                    let statusCode = response.statusCode
//                    if (200..<300).contains(statusCode) {
//                        do {
//                            let results = try JSONDecoder().decode(T.self, from: response.data)
//                            completion(.success(results))
//                        } catch let error {
//                            completion(.failure(error))
//                        }
//                    } else {
//                        do {
//                            let results = try JSONDecoder().decode(APIError.self, from: response.data)
//                            completion(.failure(results))
//                        } catch let error {
//                            completion(.failure(error))
//                        }
//                    }
//                case let .failure(error):
//                    completion(.failure(error))
//                }
//            }
//        } else {
//
//            let group = DispatchGroup()
//
//            group.enter()
//
//            tokenManager.refreshTokenIfNeeded { result in
//                defer {
//                    group.leave()
//                }
//                switch result {
//
//                case .success:
//                    self.provider.request(target) { result in
//                        switch result {
//                        case let .success(response):
//                            let statusCode = response.statusCode
//                            if (200..<300).contains(statusCode) {
//                                do {
//                                    let results = try JSONDecoder().decode(T.self, from: response.data)
//                                    completion(.success(results))
//                                } catch let error {
//                                    completion(.failure(error))
//                                }
//                            } else {
//                                do {
//                                    let results = try JSONDecoder().decode(APIError.self, from: response.data)
//                                    completion(.failure(results))
//                                } catch let error {
//                                    completion(.failure(error))
//                                }
//                            }
//                        case let .failure(error):
//                            completion(.failure(error))
//                        }
//                    }
//                case .failure(let error):
//                    completion(.failure(error))
//                    }
//                }
//            }
//        }

        func request<T: Decodable>(
            target: TargetType,
            completion: @escaping (Result<T, Error>) -> ()
        ) {
            provider.request(target) { result in
                switch result {
                case let .success(response):
                    let statusCode = response.statusCode
                    if (200..<300).contains(statusCode) {
                        do {
                            let results = try JSONDecoder().decode(T.self, from: response.data)
                            completion(.success(results))
                        } catch let error {
                            completion(.failure(error))
                        }
                    } else {
                        do {
                            let results = try JSONDecoder().decode(APIError.self, from: response.data)
                            completion(.failure(results))
                        } catch let error {
                            completion(.failure(error))
                        }
                    }
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }
}

extension NetworkManager: LoginRepositoryProtocol {
    func refreshToken(refreshToken: String, completionHandler: @escaping (RefreshTokenHandler) -> Void) {
        
        provider.request(.refreshToken(refreshToken)) { result in
            switch result {
            case let .success(response):
                let statusCode = response.statusCode
                if (200..<300).contains(statusCode) {
                    do {
                        let results = try JSONDecoder().decode(RefreshTokenResponse.self, from: response.data)
                        completionHandler(.success(results))
                    } catch let error {
                        completionHandler(.failure(error))
                    }
                } else {
                    do {
                        let results = try JSONDecoder().decode(APIError.self, from: response.data)
                        completionHandler(.failure(results))
                    } catch let error {
                        completionHandler(.failure(error))
                    }
                }
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
        //        request(target: .refreshToken(refreshToken), completion: completionHandler)
    }
    
    func getListDistricts(id: String, completionHandler: @escaping (DistrictsHandler) -> Void) {
        request(target: .getListDistricts(id: id), completion: completionHandler)
    }
    
    func getListWard(id: String, completionHandler: @escaping (WardHandler) -> Void) {
        request(target: .getListWards(id: id), completion: completionHandler)
    }
    
    func getListProvines(completionHandler: @escaping (ProvinesHandler) -> Void) {
        request(
            target: .getListProvines,
            completion: completionHandler
        )
    }
    
    func login(username: String,
               password: String,
               completionHandler: @escaping (AuthHandler) -> Void) {
        request(target: .login(userName: username,
                               password: password),
                completion: completionHandler
        )
    }
    
    func signup(
        _ user: SignUpModel,
        completionHandler: @escaping (AuthHandler) -> Void
    ) {
        request(target: .signup(user),
                completion: completionHandler
        )
    }
    
    func verifyOTP(userId: String, otp: Int, completionHandler: @escaping (AuthHandler) -> Void) {
        request(target: .verifyOTP(userId, otp: otp), completion: completionHandler)
    }
}

extension NetworkManager: StoreRepositoryProtocol {
    func markNotificationAsRead(id: String, completionHandler: @escaping (NotificationHandler) -> Void) {
        request(target: .markNotificationAsRead(id: id), completion: completionHandler)
    }
    
    func getAllStores(completionHandler: @escaping (StoreHandler) -> Void) {
        request(target: .getListAllStore, completion: completionHandler)
    }
    
    func canJoinPlayGame(campaignID: String, completionHandler: @escaping (GameHandler) -> Void) {
        request(target: .canJoinPlayGame(campaignID), completion: completionHandler)
    }
    
    func getProductItem(storeID: String, completionHandler: @escaping (ProductItemHandler) -> Void) {
        request(target: .getProductItem(storeID), completion: completionHandler)
    }
    
    func getGameLuckyWheel(campaignID: String, completionHandler: @escaping (GameLuckyWheelHandler) -> Void) {
        request(target: .getGameLuckyWheel(campaignID), completion: completionHandler)
    }
    
    func getGameOverUnder(userIsOver: Bool, campaignID: String, completionHandler: @escaping (GameLuckyWheelHandler) -> Void) {
        request(target: .getGameOverUnder(userIsOver, campaignID: campaignID), completion: completionHandler)
    }
    
    func getListVoucher(completionHandler: @escaping (ListVoucherHandler) -> Void) {
        request(target: .getListVoucher, completion: completionHandler)
    }
    
    func shareVoucher(voucherCode: String, email: String, completionHandler: @escaping (ShareVoucherHandler) -> Void) {
        request(target: .shareVoucher(voucherCode: voucherCode, email: email), completion: completionHandler)
    }
    
    func getNotifications(completionHandler: @escaping (NotificationHandler) -> Void) {
        request(target: .getListNotification, completion: completionHandler)
    }
    
    
    
    
    //    func shareVoucher(voucherCode: String, email: String, completionHandler: @escaping (Result<ShareVoucherResponse, Error>) -> Void) {
    //        request(target: .shareVoucher(voucherCode: voucherCode, email: email), completion: completionHandler)
    //    }
    //
    //    func getListVoucher(completionHandler: @escaping (Result<ListVoucherResponse, Error>) -> Void) {
    //        request(target: .getListVoucher, completion: completionHandler)
    //    }
    //
    //    func getGameOverUnder(userIsOver: Bool, campaignID: String, completionHandler: @escaping (Result<GameLuckyWheelReponse, Error>) -> Void) {
    //        request(target: .getGameOverUnder(userIsOver, campaignID: campaignID), completion: completionHandler)
    //    }
    //
    //    func getGameLuckyWheel(campaignID: String, completionHandler: @escaping (Result<GameLuckyWheelReponse, Error>) -> Void) {
    //        request(target: .getGameLuckyWheel(campaignID), completion: completionHandler)
    //    }
    //
    //
    //    func getProductItem(storeID: String, completionHandler: @escaping (ProductItemHandler) -> Void) {
    //        request(target: .getProductItem(storeID), completion: completionHandler)
    //    }
    //
    //
    //    func canJoinPlayGame(campaignID: String,
    //                         completionHandler: @escaping (GameHandler) -> Void) {
    //        request(target: .canJoinPlayGame(campaignID), completion: completionHandler)
    //    }
    //
    //    func getAllStore(completionHandler: @escaping (StoreHandler) -> Void) {
    //        request(target: .getListAllStore, completion: completionHandler)
    //    }
}

