//
//  Address.swift
//  DA_CDTKPMNC
//
//  Created by Hoang Son Vo Phuoc on 5/9/23.
//

import Foundation

struct AddressResponse: Codable {
    
    let data: ProvinesData?
    
    struct ProvinesData: Codable {
        let provines: [Provines]?
    }
 
    
    struct Provines: Codable {
        
        let id: String
        
        let fullName: String
        
        enum CodingKeys: String, CodingKey {
            case id, fullName
        }
    }
}

struct DistrictsResponse: Codable {
    
    let data: DistrictsData?
    
    struct DistrictsData: Codable {
        let districts: [District]?
    }
    
    
    struct District: Codable {
        
        let id: String
        
        let fullName: String
        
        enum CodingKeys: String, CodingKey {
            case id, fullName
        }
    }
}


struct WardResponse: Codable {
    
    let data: WardsData?
    
    struct WardsData: Codable {
        let wards: [Ward]?
    }
    
    
    struct Ward: Codable {
        
        let id: String
        
        let fullName: String
        
        enum CodingKeys: String, CodingKey {
            case id, fullName
        }
    }
}
