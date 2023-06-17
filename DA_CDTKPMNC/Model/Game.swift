//
//  Game.swift
//  DA_CDTKPMNC
//
//  Created by Hoang Son Vo Phuoc on 5/26/23.
//

import Foundation

struct GameLuckyWheelReponse: Codable {
    let data: GameLuckyWheel?

    enum CodingKeys: String, CodingKey {
        case data
    }
}

// MARK: - DataClass
struct GameLuckyWheel: Codable {
    let isWinner: Bool?
    let voucher: Voucher?
    let gameData: GameData?
    
    enum CodingKeys: String, CodingKey {
        case isWinner
        case voucher
        case gameData
    }
}

// MARK: - Voucher
struct Voucher: Codable {
    let voucherCode: String?
    let voucherName: String?
    let description: String?
    let storeID: String?
    let storeName: String?
    let campaignID: String?
    let campaignName: String?
    let expiresOn: ExpiresOn?
    
    enum CodingKeys: String, CodingKey {
        case voucherCode
        case voucherName
        case description
        case storeID
        case storeName
        case campaignID
        case campaignName
        case expiresOn
    }
}

// MARK: - GameData
struct GameData: Codable {
    let gameIsOver: Bool?
    let userIsOver: Bool?
    let sumScore: Int?
    let dices: Dices?

    enum CodingKeys: String, CodingKey {
        case gameIsOver
        case userIsOver
        case sumScore
        case dices
    }
}

struct Dices: Codable {
    let dice1: Int?
    let dice2: Int?
    let dice3: Int?

    enum CodingKeys: String, CodingKey {
        case dice1 = "dice_1"
        case dice2 = "dice_2"
        case dice3 = "dice_3"
    }
}
