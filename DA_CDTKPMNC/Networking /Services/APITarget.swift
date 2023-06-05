//
//  APITarget.swift
//  DA_CDTKPMNC
//
//  Created by Hoang Son Vo Phuoc on 5/7/23.
//

import Foundation
import Moya
import Alamofire

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
    
    case signup(_ user: SignUpModel)
    
    case verifyOTP(_ userId: String, otp: Int)
    
    case getListAllStore
    
    case canJoinPlayGame(_ campaignID: String)
    
    case refreshToken(_ refreshToken: String)
    
    case getProductItem(_ storeID: String)
    
    case getGameLuckyWheel(_ campaignID: String)
    
    case getGameOverUnder(_ userIsOver: Bool, campaignID: String)
    
    case getListVoucher
    
    case shareVoucher(voucherCode: String, email: String)
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
            
        case .signup:
            return "EndUser/Register"
            
        case .verifyOTP(let userId, _):
            return "EndUser/VerifyRegister/\(userId)"
            
        case .getListAllStore:
            return "EndUser/Store/All"
            
        case .canJoinPlayGame(let campaignID):
            return "Campaign/CanJoin/\(campaignID)"
            
        case .refreshToken:
            return "EndUser/RefreshToken"
            
        case .getProductItem(let storeID):
            return "ProductItem/Available/\(storeID)"
            
        case .getGameLuckyWheel(let campaignID):
            return "Game/LuckyWheel/\(campaignID)"
            
        case .getGameOverUnder(let userIsUnder, let campaignID):
            return "Game/OverUnder/\(userIsUnder)/\(campaignID)"
            
        case .getListVoucher:
            return "Voucher/All"
            
        case .shareVoucher:
            return "Voucher/Share"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login, .signup, .verifyOTP, .refreshToken:
            return .post
            
        case .shareVoucher:
            return .put
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Moya.Task {
        switch self {
        case .login, .signup, .verifyOTP, .refreshToken, .shareVoucher:
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
            
        case .signup(let user):
            params["userName"] = user.userName
            params["password"] = user.password
            
            params["name"] = user.name
            params["gender"] = user.gender
            
            params["dateOfBirth"] = user.dateOfBirth.toJson()
            params["address"] = user.address.toJson()
            
        case .verifyOTP(_, let otp):
            params["otpValue"] = otp
            
        case .refreshToken(let refreshToken):
            params["token"] = refreshToken
            
        case .shareVoucher(let voucherCode, let email):
            params["voucherCode"] = voucherCode
            params["destinationUser"] = email
        default:
            return [:]
        }
        return params
    }
}
