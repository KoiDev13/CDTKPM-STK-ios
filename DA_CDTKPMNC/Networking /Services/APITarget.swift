//
//  APITarget.swift
//  DA_CDTKPMNC
//
//  Created by Hoang Son Vo Phuoc on 5/7/23.
//

import Foundation
import Moya

enum APITarget {
    case login(
        userName: String,
        password: String
    )
    
    case getListProvines
    
    case getListDistricts(
        id: String
    )
    
    case getListWards(
        id: String
    )
}

extension APITarget: TargetType {
    var baseURL: URL {
        switch self {
        default:
            guard let url = URL(string: Constants.API.baseURL) else { fatalError() }
            return url
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "EndUser/Login"
            
        case .getListProvines:
            return "Address/Provines"
            
        case .getListDistricts:
            return "Address/District/ProvineId"
            
        case .getListWards:
            return "Address/Ward/DistrictId"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
            
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Moya.Task {
        switch self {
        case .login:
            return .requestParameters(
                parameters: parameters,
                encoding: JSONEncoding.default
            )
        default:
            return .requestParameters(
                parameters: parameters,
                encoding: URLEncoding.default
            )
        }
    }
    
    var headers: [String : String]? {
        var headers : [String: String] = [:]
        switch self {
//        case .fetchListLoyaltyBrands,:
//            if let token = LocalStorageManager.shared.fetchCredential() {
//                headers["Authorization"] = "Bearer \(token)"
//            }
//            return headers
        default:
            headers["Content-Type"] = "application/json"
            return headers
        }
    }
    
    var parameters: [String: Any] {
        var params: [String: Any] = [:]
        switch self {
        case .login(let userName, let password):
            params["userName"] = userName
            params["password"] = password
            
        case .getListDistricts(let id):
            params["ProvineId"] = id
            
        case .getListWards(let id):
            params["DistrictId"] = id
        default:
            return [:]
        }
        return params
    }
}
