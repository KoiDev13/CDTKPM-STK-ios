//
//  Constants.swift
//  DA_CDTKPMNC
//
//  Created by Hoang Son Vo Phuoc on 5/7/23.
//

import Foundation

enum Constants {
    enum API {
#if DEBUG
        static let baseURL = "https://api.vovanthuong.online/"
#else
        
#endif
    }
    
    enum OtherURLs {
#if DEBUG
        
#else
        
#endif
    }
    
    enum Appearance {
        static let isLightContent = false
    }
}
