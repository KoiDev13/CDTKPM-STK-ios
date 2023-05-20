//
//  User.swift
//  DA_CDTKPMNC
//
//  Created by Hoang Son Vo Phuoc on 5/8/23.
//

import Foundation
import SwiftyUserDefaults

struct UserProfileResponse: Codable, DefaultsSerializable {
    
    let success: Bool?
    let message: String?
    let data: UserProfile?

    enum CodingKeys: String, CodingKey {
        case success
        case message
        case data
    }
    
    static var _defaults: DefaultsCodableBridge<UserProfileResponse> { return DefaultsCodableBridge<UserProfileResponse>() }
    static var _defaultsArray: DefaultsCodableBridge<[UserProfileResponse]> { return  DefaultsCodableBridge<[UserProfileResponse]>()}
}

// MARK: - DataClass
struct UserProfile: Codable, DefaultsSerializable {
    let account: Account?
    let token: Token?

    enum CodingKeys: String, CodingKey {
        case account
        case token
    }
}

// MARK: - Account
struct Account: Codable, DefaultsSerializable {
    let address: Address?
    let id: String?
    let userName: String?
    let name: String?
    let gender: String?
    let dateOfBirth: DateOfBirth?
    let createdAt: String?
    let verifiedAt: String?

    enum CodingKeys: String, CodingKey {
        case address
        case id
        case userName
        case name
        case gender
        case dateOfBirth
        case createdAt
        case verifiedAt
    }
}

// MARK: - Address
struct Address: Codable, DefaultsSerializable {
    let ward: Ward?
    let street: String?

    enum CodingKeys: String, CodingKey {
        case ward
        case street
    }
}

// MARK: - Ward
struct Ward: Codable, DefaultsSerializable {
    let district: District?
    let province: District?
    let id: String?
    let name: String?
    let fullName: String?
    let nameEN: String?
    let fullNameEN: String?

    enum CodingKeys: String, CodingKey {
        case district
        case province
        case id
        case name
        case fullName
        case nameEN
        case fullNameEN
    }
}

// MARK: - District
struct District: Codable, DefaultsSerializable {
    let id: String?
    let name: String?
    let fullName: String?
    let nameEN: String?
    let fullNameEN: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName
        case nameEN
        case fullNameEN
    }
}

// MARK: - DateOfBirth
struct DateOfBirth: Codable, DefaultsSerializable {
    let year: Int?
    let month: Int?
    let day: Int?
    let dayOfWeek: String?
    let dayOfYear: Int?
    let dayNumber: Int?

    enum CodingKeys: String, CodingKey {
        case year
        case month
        case day
        case dayOfWeek
        case dayOfYear
        case dayNumber
    }
}

// MARK: - Token
struct Token: Codable, DefaultsSerializable {
    let accessToken: String?
    let refreshToken: String?

    enum CodingKeys: String, CodingKey {
        case accessToken
        case refreshToken
    }
}
