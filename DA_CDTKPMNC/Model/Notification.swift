//
//  Notification.swift
//  DA_CDTKPMNC
//
//  Created by Hoang Son Vo Phuoc on 6/7/23.
//

import Foundation

struct NotificationResponse: Codable {
    let success: Bool
    let message: String
    let data: NotificationData?
}

struct NotificationData: Codable {
    let notication: Notification?
    let notications: NotificationInfo?
}

struct NotificationInfo: Codable {
    let haveUnread: Bool?
    let numberUnread: Int?
    let notications: [Notification]?
}

struct Notification: Codable {
    let id: String
    let accountId: String?
    let title: String?
    let message: String?
    let createdAt: String?
    var isRead: Bool?

    private enum CodingKeys: String, CodingKey {
        case id
        case accountId
        case title
        case message
        case createdAt = "createAt"
        case isRead
    }
}
