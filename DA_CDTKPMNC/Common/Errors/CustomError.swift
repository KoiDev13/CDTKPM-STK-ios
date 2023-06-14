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
enum NetworkError: Error {
    case invalidResponse
    case requestFailed
    case invalidURL

    var localizedDescription: String {
        switch self {
        case .invalidResponse:
            return "Invalid response from the server."
        case .requestFailed:
            return "Request failed. Please try again later."
        case .invalidURL:
            return "Invalid URL."
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
