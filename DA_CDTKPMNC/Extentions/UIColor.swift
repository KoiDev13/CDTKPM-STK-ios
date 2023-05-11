//
//  UIColor.swift
//  DA_CDTKPMNC
//
//  Created by Hoang Son Vo Phuoc on 5/7/23.
//

import UIKit

extension UIColor {
    
    convenience init(hex:String) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: CGFloat(1.0))
    }
}

extension UIColor {
    
    enum App {
        
        static let primaryBackground = UIColor(hex: "#002238")
        static let secondaryBackground = UIColor(hex: "#F6FDFF")
        static let primaryTitle = UIColor(hex: "#B2DAFD")
        static let primaryDarkBlueTitle = UIColor(hex: "#B2BBC3")
        static let secondaryTitle = UIColor.white
        static let primaryOnDarkBlue = UIColor(hex: "#58C2F1")
        static let secondaryOnDarkBlue = UIColor(hex: "#80C2FC")
        static let primaryTextField = UIColor(hex: "#33495E")
        static let primaryButton = UIColor(hex: "#2DC3B1")
        static let primaryPlaceholderTextField = UIColor(hex: "#E5E8EB")
        static let primaryDarkBlueButton = UIColor(hex: "#19324A")
        static let secondaryOnBlue = UIColor(hex: "#828B92")
        static let primaryYellow = UIColor(hex: "#F5C748")
        static let primaryOrange = UIColor(hex: "#FE7B50")
    }
}

