//
//  Store.swift
//  DA_CDTKPMNC
//
//  Created by Hoang Son Vo Phuoc on 5/23/23.
//

import Foundation

struct AllStoresReponse: Codable {
    let success: Bool?
    let message: String?
    let data: StoresReponse?

    enum CodingKeys: String, CodingKey {
        case success
        case message
        case data
    }
}

// MARK: - StoresReponse
struct StoresReponse: Codable {
    let stores: [Store]?

    enum CodingKeys: String, CodingKey {
        case stores
    }
}

// MARK: - Store
struct Store: Codable {
    let id: String
    let name: String?
    let description: String?
    let bannerURL: String?
    let campaign: Campaign?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case bannerURL = "bannerUrl"
        case campaign
    }
}

// MARK: - Campaign
struct Campaign: Codable {
    let id: String
    let name: String?
    let description: String?
    let storeID: String?
    let storeName: String?
    let gameID: String?
    let gameName: String?
    let isEnable: Bool?
    let campaignVoucherList: [CampaignVoucherList]?
    let status: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case storeID
        case storeName
        case gameID
        case gameName
        case isEnable
        case campaignVoucherList
        case status
    }
}

// MARK: - CampaignVoucherList
struct CampaignVoucherList: Codable {
    
    let id: String?
    let name: String?
    let description: String?
    let createdAt: String?
    let quantity: Int?
    let quantityUsed: Int?
    let expiresOn: ExpiresOn?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case createdAt
        case quantity
        case quantityUsed
        case expiresOn
    }
}

// MARK: - ExpiresOn
struct ExpiresOn: Codable {
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

struct RefreshTokenResponse: Codable {
    let success: Bool?
    let message: String?
    let data: RefreshToken?

    enum CodingKeys: String, CodingKey {
        case success
        case message
        case data
    }
}

// MARK: - RefreshToken
struct RefreshToken: Codable {
    let accessToken: String?
    let refreshToken: String?

    enum CodingKeys: String, CodingKey {
        case accessToken
        case refreshToken
    }
}


struct ProductResponse: Codable {
    let data: Product?

    enum CodingKeys: String, CodingKey {
        case data
    }
}

// MARK: - DataClass
struct Product: Codable {
    let productItems: [ProductItem]?

    enum CodingKeys: String, CodingKey {
        case productItems
    }
}

// MARK: - ProductItem
struct ProductItem: Codable {
    let productCategory: ProductCategory?
    let id: String?
    let name: String?
    let description: String?
    let storeID: String?
    let productCategoryID: String?
    let price: Int?
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case productCategory
        case id
        case name
        case description
        case storeID
        case productCategoryID
        case price
        case imageURL = "imageUrl"
    }
}

// MARK: - ProductCategory
struct ProductCategory: Codable {
    let id: String?
    let name: String?
    let description: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
    }
}

struct ListVoucherResponse: Codable {
    let data: ListVoucher?

    enum CodingKeys: String, CodingKey {
        case data
    }
}

// MARK: - DataClass
struct ListVoucher: Codable {
    let vouchers: [Voucher]?

    enum CodingKeys: String, CodingKey {
        case vouchers
    }
}

struct ShareVoucherResponse: Codable {
    let success: Bool?
    let message: String?

    enum CodingKeys: String, CodingKey {
        case success
        case message
    }
}

// MARK: - Voucher
//struct Voucher: Codable {
//    let voucherCode: String?
//    let voucherName: String?
//    let description: String?
//    let storeID: String?
//    let storeName: String?
//    let campaignID: String?
//    let campaignName: String?
//    let endUserID: String?
//    let endUserName: String?
//    let isUsed: Bool?
//
//    enum CodingKeys: String, CodingKey {
//        case voucherCode
//        case voucherName
//        case description
//        case storeID
//        case storeName
//        case campaignID
//        case campaignName
//        case endUserID
//        case endUserName
//        case isUsed
//    }
//}
