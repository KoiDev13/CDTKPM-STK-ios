//
//  StoreRepositoryProtocol.swift
//  DA_CDTKPMNC
//
//  Created by Hoang Son Vo Phuoc on 5/23/23.
//

import Foundation

//protocol StoreRepositoryProtocol {
    
//    typealias StoreHandler = Result<AllStoresReponse, Error>
//
//    typealias GameHandler = Result<PlayGameResponse, Error>
//
//    typealias ProductItemHandler = Result<ProductResponse, Error>
//
//    func getAllStore(completionHandler: @escaping (StoreHandler) -> Void)
//
//    func canJoinPlayGame(campaignID: String,
//                         completionHandler: @escaping (GameHandler) -> Void)
//
//    func getProductItem(storeID: String,
//                        completionHandler: @escaping (ProductItemHandler) -> Void)
//
//    func getGameLuckyWheel(campaignID: String,
//                           completionHandler: @escaping (Result<GameLuckyWheelReponse, Error>) -> Void)
//
//    func getGameOverUnder(userIsOver: Bool,
//                          campaignID: String,
//                          completionHandler: @escaping (Result<GameLuckyWheelReponse, Error>) -> Void)
//
//    func getListVoucher(completionHandler: @escaping (Result<ListVoucherResponse, Error>) -> Void)
//
//    func shareVoucher(voucherCode: String, email: String, completionHandler: @escaping (Result<ShareVoucherResponse, Error>) -> Void)
//
//    func getListVoucher(completionHandler: @escaping (Result<NotificationResponse, Error>) -> Void)
    
//}


protocol StoreRepositoryProtocol {
    
    typealias StoreHandler = Result<AllStoresReponse, Error>
    typealias GameHandler = Result<PlayGameResponse, Error>
    typealias ProductItemHandler = Result<ProductResponse, Error>
    typealias GameLuckyWheelHandler = Result<GameLuckyWheelReponse, Error>
    typealias ListVoucherHandler = Result<ListVoucherResponse, Error>
    typealias ShareVoucherHandler = Result<ShareVoucherResponse, Error>
    typealias NotificationHandler = Result<NotificationResponse, Error>
    
    func getAllStores(completionHandler: @escaping (StoreHandler) -> Void)
    
    func canJoinPlayGame(campaignID: String, completionHandler: @escaping (GameHandler) -> Void)
    
    func getProductItem(storeID: String, completionHandler: @escaping (ProductItemHandler) -> Void)
    
    func getGameLuckyWheel(campaignID: String, completionHandler: @escaping (GameLuckyWheelHandler) -> Void)
    
    func getGameOverUnder(userIsOver: Bool, campaignID: String, completionHandler: @escaping (GameLuckyWheelHandler) -> Void)
    
    func getListVoucher(completionHandler: @escaping (ListVoucherHandler) -> Void)
    
    func shareVoucher(voucherCode: String, email: String, completionHandler: @escaping (ShareVoucherHandler) -> Void)
    
    func getNotifications(completionHandler: @escaping (NotificationHandler) -> Void)
    
    func markNotificationAsRead(id: String, completionHandler: @escaping (NotificationHandler) -> Void)
}
