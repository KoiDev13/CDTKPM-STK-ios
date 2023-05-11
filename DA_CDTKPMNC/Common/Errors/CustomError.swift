//
//  CustomError.swift
//  DA_CDTKPMNC
//
//  Created by Hoang Son Vo Phuoc on 5/8/23.
//

import Foundation

enum CustomError: Error, LocalizedError {

    case message(String)
    case somethingWentWrong

    var errorDescription: String? {
        switch self {
        case .somethingWentWrong:
            return "Something went wrong !"
        case .message(let desc):
            return desc
        }
    }
}

struct APIError: Error, Codable, LocalizedError {
    let message: String

    enum CodingKeys: String, CodingKey {
        case message = "message"
    }

    var errorDescription: String? {
        message.lowercased()
    }
}
