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
    
    private lazy var networkInterceptor: NetworkInterceptor = {
        let networkInterceptor = NetworkInterceptor()
        return networkInterceptor
    }()

    private lazy var session: Session = {
        let sesstion = Session(interceptor: networkInterceptor)
        return sesstion
    }()

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
    
    private init() {}

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
        request(target: .refreshToken(refreshToken), completion: completionHandler)
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
    
    func canJoinPlayGame(campaignID: String,
                         completionHandler: @escaping (GameHandler) -> Void) {
        request(target: .canJoinPlayGame(campaignID), completion: completionHandler)
    }
    
    func getAllStore(completionHandler: @escaping (StoreHandler) -> Void) {
        request(target: .getListAllStore, completion: completionHandler)
    }
    
    
}
