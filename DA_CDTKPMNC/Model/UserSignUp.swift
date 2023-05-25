//
//  UserSignUp.swift
//  DA_CDTKPMNC
//
//  Created by Hoang Son Vo Phuoc on 5/12/23.
//

//import Foundation
//
//struct UserSignUp: Codable {
//    let success: Bool?
//    let message: String?
//    let data: DataClass?
//}
//
//// MARK: - DataClass
//struct DataClass: Codable {
//    let account: UserAccount?
//}
//
//// MARK: - UserAccount
//struct UserAccount: Codable {
//    let id, userName, name, gender: String?
//}

struct PlayGameResponse: Codable {
    let success: Bool?
    let message: String?
    let data: PlayGame?

    enum CodingKeys: String, CodingKey {
        case success
        case message
        case data
    }
}

// MARK: - DataClass
struct PlayGame: Codable {
    let canJoin: Bool?

    enum CodingKeys: String, CodingKey {
        case canJoin
    }
}
