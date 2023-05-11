//
//  UITextField.swift
//  DA_CDTKPMNC
//
//  Created by Hoang Son Vo Phuoc on 5/7/23.
//

import UIKit

extension UITextField {
    
    func enablePasswordToggle(){
        let button = UIButton(type: .custom)
        isSecureTextEntry = true
        button.isSelected = false
        button.setImage(UIImage(named: "ic_hide_toggle"), for: .normal)
        button.setImage(UIImage(named: "ic_show_toggle"), for: .selected)
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        button.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        rightView = button
        rightViewMode = .always
    }
    
    @objc func togglePasswordView(_ sender: UIButton) {
        sender.isSelected.toggle()
        isSecureTextEntry = !sender.isSelected
    }
    
}
