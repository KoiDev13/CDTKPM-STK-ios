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
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "User Name"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var dobLabel: UILabel = {
        let label = UILabel()
        label.text = "Date of Birth"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.text = "Address"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.white, for: .normal) // Đặt màu chữ là trắng
        button.backgroundColor = .blue // Đặt màu nền là xanh lam
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    
    //    private lazy var logoutButton: PrimaryButton = {
    //        let button = PrimaryButton()
    //        button.configure("Logout",
    //                         titleColor: .white,
    //                         backgroundColor: UIColor.App.primaryButton,
    //                         font: UIFont.systemFont(ofSize: 16))
    //        button.addTarget(self,
    //                         action: #selector(onClickToLogoutButton),
    //                         for: .touchUpInside)
    //        return button
    //    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        setupUI()
        
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(userNameLabel)
        view.addSubview(dobLabel)
        view.addSubview(addressLabel)
        view.addSubview(logoutButton)
    }
    
    func setupConstraints() {
        userNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
        }
        
        dobLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(userNameLabel.snp.bottom).offset(20)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(dobLabel.snp.bottom).offset(20)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(addressLabel.snp.bottom).offset(40)
            make.left.right.equalToSuperview().inset(18)
            make.height.equalTo(50)
        }
    }
    
    @objc func logoutButtonTapped() {
        LocalStorageManager.shared.clear()
        delegate?.didLogoutSuccessfully()
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
