//
//  StoreRepositoryProtocol.swift
//  DA_CDTKPMNC
//
//  Created by Hoang Son Vo Phuoc on 5/23/23.
//

import Foundation

protocol StoreRepositoryProtocol {
    
    typealias StoreHandler = Result<AllStoresReponse, Error>
    
    typealias GameHandler = Result<PlayGameResponse, Error>
    
    func getAllStore(completionHandler: @escaping (StoreHandler) -> Void)
    
    func canJoinPlayGame(campaignID: String,
                         completionHandler: @escaping (GameHandler) -> Void)
}
