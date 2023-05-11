//
//  LoginRepositoryProtocol.swift
//  DA_CDTKPMNC
//
//  Created by Hoang Son Vo Phuoc on 5/7/23.
//

import Foundation

protocol LoginRepositoryProtocol {
    
    typealias AuthHandler = Result<UserProfileResponse, Error>
    typealias ProvinesHandler = Result<AddressResponse, Error>
    typealias DistrictsHandler = Result<DistrictsResponse, Error>
    typealias WardHandler = Result<WardResponse, Error>
    
    func login(username: String,
               password: String,
               completionHandler: @escaping (AuthHandler) -> Void)
    
    func getListProvines(completionHandler: @escaping (ProvinesHandler) -> Void)
    
    func getListDistricts(id: String,
                          completionHandler: @escaping (DistrictsHandler) -> Void)
    
    func getListWard(id: String,
                     completionHandler: @escaping (WardHandler) -> Void)
}
