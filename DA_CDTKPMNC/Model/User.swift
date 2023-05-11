//
//  User.swift
//  DA_CDTKPMNC
//
//  Created by Hoang Son Vo Phuoc on 5/8/23.
//

import Foundation
import SwiftyUserDefaults

class UserProfileResponse: Codable, DefaultsSerializable {
    let data: UserProfile

    static var _defaults: DefaultsCodableBridge<UserProfileResponse> { return DefaultsCodableBridge<UserProfileResponse>() }
    static var _defaultsArray: DefaultsCodableBridge<[UserProfileResponse]> { return  DefaultsCodableBridge<[UserProfileResponse]>()}
}

extension UserProfileResponse {
    
    class AccountToken: Codable, DefaultsSerializable {
        
        let accessToken: String?
        
        let refreshToken: String?
        
        enum CodingKeys: String, CodingKey {
            case accessToken = "accessToken"
            case refreshToken = "refreshToken"
        }
    }

    class UserProfile: Codable, DefaultsSerializable {
        let userName: String?
        let id: String
        let accountToken: AccountToken?

        enum CodingKeys: String, CodingKey {
            case userName
            case id
            case accountToken
        }
    }
}

