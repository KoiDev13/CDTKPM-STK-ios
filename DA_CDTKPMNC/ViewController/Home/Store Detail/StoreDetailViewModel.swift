//
//  StoreDetailViewModel.swift
//  DA_CDTKPMNC
//
//  Created by Hoang Son Vo Phuoc on 5/24/23.
//

import Foundation

class StoreDetailViewModel {
    
    let store: Store
    
    init(store: Store) {
        self.store = store
    }
    
    var isCanJoinGame: Bool = false
    
    func canJoinPlayGame(campaignID: String, completionHandler: @escaping (Result<PlayGameResponse, Error>) -> Void) {
        
        NetworkManager.shared.canJoinPlayGame(campaignID: campaignID) { result in
            
            switch result {
                
            case .success(let response):
            
                self.isCanJoinGame = response.data?.canJoin ?? false
                
                completionHandler(.success(response))
                
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
}
