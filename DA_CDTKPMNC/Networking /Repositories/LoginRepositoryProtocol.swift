//
//  LoginRepositoryProtocol.swift
//  DA_CDTKPMNC
//
//  Created by Hoang Son Vo Phuoc on 5/7/23.
//

import Foundation

struct SignUpModel: Codable {
    
    let userName, password, name: String
    let gender: Int
    let birthDate: BirthDate
    let address: Address
    
    struct Address: Codable {
        let wardID, street: String

        enum CodingKeys: String, CodingKey {
            case wardID = "wardId"
            case street
        }
        
        func toJson() -> [String: Any?] {
            return ["wardID" : wardID ,
                    "street" : street
            ]
        }
    }
    
    struct BirthDate: Codable {
        let year, month, day: Int
        
        func toJson() -> [String: Any?] {
            return ["year" : year ,
                    "month" : month,
                    "day": day
            ]
        }
    }

    
}

protocol LoginRepositoryProtocol {
    
    typealias AuthHandler = Result<UserProfileResponse, Error>
    typealias ProvinesHandler = Result<AddressResponse, Error>
    typealias DistrictsHandler = Result<DistrictsResponse, Error>
    typealias WardHandler = Result<WardResponse, Error>
    
    func login(username: String,
               password: String,
               completionHandler: @escaping (AuthHandler) -> Void)
    
    func getListProvines(completionHandler: @escaping (ProvinesHandler) -> Void)
    
    func getListDistricts(id: String,
                          completionHandler: @escaping (DistrictsHandler) -> Void)
    
    func getListWard(id: String,
                     completionHandler: @escaping (WardHandler) -> Void)
    
    func signup(_ user: SignUpModel,
                completionHandler: @escaping (AuthHandler) -> Void)
    
    func verifyOTP(userId: String,
               otp: Int,
               completionHandler: @escaping (AuthHandler) -> Void)
}
