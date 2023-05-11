//
//  ProfileViewController.swift
//  DA_CDTKPMNC
//
//  Created by Hoang Son Vo Phuoc on 5/9/23.
//

import UIKit

protocol ProfileViewControllerDelegate: AnyObject {
    func didLogoutSuccessfully()
}

class ProfileViewController: UIViewController {
    
    weak var delegate: ProfileViewControllerDelegate?

    private lazy var logoutButton: PrimaryButton = {
        let button = PrimaryButton()
        button.configure("Logout",
                         titleColor: .white,
                         backgroundColor: UIColor.App.primaryButton,
                         font: UIFont.systemFont(ofSize: 16))
        button.addTarget(self,
                         action: #selector(onClickToLogoutButton),
                         for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.App.primaryBackground
        
        view.addSubview(logoutButton)
        
        logoutButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(18)
            make.height.equalTo(50)
        }
    }

    @objc private func onClickToLogoutButton() {
        LocalStorageManager.shared.clear()
        delegate?.didLogoutSuccessfully()
    }
}
