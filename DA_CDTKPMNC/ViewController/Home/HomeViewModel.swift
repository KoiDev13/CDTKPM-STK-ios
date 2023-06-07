//
//  HomeViewModel.swift
//  DA_CDTKPMNC
//
//  Created by Hoang Son Vo Phuoc on 5/23/23.
//

import Foundation

class HomeViewModel {
    
    var stores: [Store] = []
    
    
    
    func getAllStore(completionHandler: @escaping (Result<AllStoresReponse, Error>) -> Void) {
        
        NetworkManager.shared.getAllStores { result in
            
            switch result {
                
            case .success(let response):
            
                self.stores = response.data?.stores ?? []
                
                completionHandler(.success(response))
                
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}

extension HomeViewModel {
    
    func numberOfItem() -> Int {
        stores.count
    }
    
    func itemAtIndex(_ index: Int) -> Store {
        stores[index]
    }
}
