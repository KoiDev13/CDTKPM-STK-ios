//
//  LocalStorageManager.swift
//  DA_CDTKPMNC
//
//  Created by Hoang Son Vo Phuoc on 5/9/23.
//

import Foundation
import SwiftyUserDefaults

final class LocalStorageManager {
    
    static let shared = LocalStorageManager()
    
    private init() {}
}

extension LocalStorageManager {
    
    func fetchCredential() -> String? {
        Defaults[\.credential]
    }
    
    func updateCredential(_ credential: String) {
        Defaults[\.credential] =  credential
    }
    
    func fetchCurrentUser() -> UserProfile? {
        Defaults[\.currentUser]
    }
    
    func saveUser(_ user: UserProfile?) {
        Defaults[\.currentUser] = user
    }
    
    func clear() {
        Defaults[\.credential] = nil
        Defaults[\.currentUser] = nil
        
    }
}

private extension DefaultsKeys {
    var credential: DefaultsKey<String?> {.init("credential")}
    var currentUser: DefaultsKey<UserProfile?> {.init("currentUser")}
}

