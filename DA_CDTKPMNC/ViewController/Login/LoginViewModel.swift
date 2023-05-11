//
//  LoginViewModel.swift
//  DA_CDTKPMNC
//
//  Created by Hoang Son Vo Phuoc on 5/9/23.
//

import Foundation

class LoginViewModel {
    
    func login(username: String,
               password: String,
               completionHandler: @escaping (Result<UserProfileResponse, Error>) -> Void) {
        
        NetworkManager.shared.login(username: username, password: password) { result in
            
            switch result {
                
            case .success(let user):
                
                LocalStorageManager.shared.saveUser(user.data)
                LocalStorageManager.shared.updateCredential(user.data.accountToken?.accessToken ?? "")
                
                completionHandler(.success(user))
                
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
