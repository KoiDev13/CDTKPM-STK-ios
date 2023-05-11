//
//  SignUpViewController.swift
//  DA_CDTKPMNC
//
//  Created by Hoang Son Vo Phuoc on 5/9/23.
//

import UIKit

class CellClass: UITableViewCell {
    
}

enum Dropdown {
    case gender
    case provines
    case districts
    case wards
}

class SignUpViewController: UIViewController {

//    let transparentView = UIView()
    
//    var dataSource = [String]()
//    var selectedButton = UIButton()
//
    
    
    
    
    var selectedProvines: AddressResponse.Provines?
    var selectedDistrict: DistrictsResponse.District?
    var selectedWard: WardResponse.Ward?
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_logo_mini")
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello there!"
        label.numberOfLines = 0
        label.textColor = UIColor.App.secondaryTitle
        label.font = UIFont.systemFont(ofSize: 40)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Start redeem points and enjoy many perks for loyalty program!"
        label.textColor = UIColor.App.secondaryTitle
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var passwordTextField: PrimaryTextField = {
        let textField = PrimaryTextField()
        textField.autocapitalizationType = .none
        textField.enablePasswordToggle()
        textField.isSecureTextEntry = true
        textField.configure("Your password ")
        textField.font = UIFont.systemFont(ofSize: 16)
        return textField
    }()
    
    private lazy var confirmPasswordTextField: PrimaryTextField = {
        let textField = PrimaryTextField()
        textField.autocapitalizationType = .none
        textField.enablePasswordToggle()
        textField.isSecureTextEntry = true
        textField.configure("Confirm your password ")
        textField.font = UIFont.systemFont(ofSize: 16)
        return textField
    }()
    
    private lazy var emailTextField: PrimaryTextField = {
        let textField = PrimaryTextField()
        textField.autocapitalizationType = .none
        textField.configure("Your email ")
        textField.font = UIFont.systemFont(ofSize: 16)
        return textField
    }()
    
    private lazy var nameTextField: PrimaryTextField = {
        let textField = PrimaryTextField()
        textField.autocapitalizationType = .none
        textField.configure("Your name ")
        textField.font = UIFont.systemFont(ofSize: 16)
        return textField
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var signupButton: SecondaryButton = {
        let button = SecondaryButton()
        button.configure("Let’s start!",
                         backgroundColor: .clear,
                         font: UIFont.systemFont(ofSize: 16),
                         borderColor: UIColor.App.secondaryOnDarkBlue,
                         titleColor: UIColor.App.primaryOnDarkBlue)
        button.addTarget(self,
                         action: #selector(onClickToLoginButton),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var chooseGenderButton: SecondaryButton = {
        let button = SecondaryButton()
        button.configure("Choose gender",
                         backgroundColor: .clear,
                         font: UIFont.systemFont(ofSize: 16),
                         borderColor: UIColor.App.secondaryOnDarkBlue,
                         titleColor: UIColor.App.primaryOnDarkBlue)
        button.addTarget(self,
                         action: #selector(onClickToChooseGenderButton),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var chooseProvinesButton: SecondaryButton = {
        let button = SecondaryButton()
        button.configure("Choose provines",
                         backgroundColor: .clear,
                         font: UIFont.systemFont(ofSize: 16),
                         borderColor: UIColor.App.secondaryOnDarkBlue,
                         titleColor: UIColor.App.primaryOnDarkBlue)
        button.addTarget(self,
                         action: #selector(onClickToChooseProvinesButton),
                         for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
       
        
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.App.primaryBackground
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        containerView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
        }
    
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(105)
            make.left.right.equalToSuperview().inset(28)
        }
        
        containerView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(28)
        }
        
        containerView.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(66)
            make.left.right.equalToSuperview().inset(18)
            make.height.equalTo(56)
        }
        
        containerView.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(18)
            make.height.equalTo(56)
        }
        
        containerView.addSubview(confirmPasswordTextField)
        confirmPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(18)
            make.height.equalTo(56)
        }
        
        containerView.addSubview(nameTextField)
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(18)
            make.height.equalTo(56)
        }
        
        containerView.addSubview(chooseGenderButton)
        chooseGenderButton.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(18)
            make.height.equalTo(50)
        }
        
        containerView.addSubview(chooseProvinesButton)
        chooseProvinesButton.snp.makeConstraints { make in
            make.top.equalTo(chooseGenderButton.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(18)
            make.height.equalTo(50)
        }
        
        containerView.addSubview(signupButton)
        signupButton.snp.makeConstraints { make in
            make.top.equalTo(chooseProvinesButton.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(18)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-50)
        }
    }
    
    
    
    private func login() {
        
//        guard let username = emailTextField.text else {
//            return
//        }
//
//        guard let password = passwordTextField.text else {
//            return
//        }
//
//        viewModel.login(username: username, password: password) { [weak self] result in
//
//            guard let self = self else {
//                return
//            }
//
//            switch result {
//
//            case .success(_):
//
//                self.delegate?.didLoginSuccessfully()
//
//            case .failure(let error):
//
//                debugPrint(error.localizedDescription)
//            }
//        }
    }
    
//    func addTransparentView(frames: CGRect) {
////        let window = UIApplication.shared.keyWindow
////        transparentView.frame = window?.frame ?? self.view.frame
//        view.addSubview(transparentView)
//        transparentView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//
////        tableView.frame = CGRect(
////            x: frames.origin.x,
////            y: frames.origin.y + frames.height,
////            width: frames.width,
////            height: 0)
//        view.addSubview(tableView)
//        tableView.layer.cornerRadius = 5
//
//        tableView.snp.makeConstraints { make in
//            make.left.right.equalToSuperview().inset(18)
//            make.centerY.equalToSuperview()
//            make.height.equalTo(0)
//        }
//
//        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
//        tableView.reloadData()
//        let tapgesture = UITapGestureRecognizer(
//            target: self,
//            action: #selector(removeTransparentView)
//        )
//        transparentView.addGestureRecognizer(tapgesture)
//        transparentView.alpha = 0
//        UIView.animate(
//            withDuration: 0.4,
//            delay: 0.0,
//            usingSpringWithDamping: 1.0,
//            initialSpringVelocity: 1.0,
//            options: .curveEaseInOut,
//            animations: {
//                self.transparentView.alpha = 0.5
//                self.tableView.snp.updateConstraints { make in
//                    make.height.equalTo(100)
//                }
////            self.tableView.frame = CGRect(
////                x: frames.origin.x,
////                y: frames.origin.y + frames.height + 5,
////                width: frames.width,
////                height: CGFloat(self.dataSource.count * 50)
////            )
//        }, completion: nil)
//    }
//
//    @objc func removeTransparentView() {
//        transparentView.removeFromSuperview()
//        tableView.removeFromSuperview()
////        let frames = selectedButton.frame
////        UIView.animate(
////            withDuration: 0.4,
////            delay: 0.0,
////            usingSpringWithDamping: 1.0,
////            initialSpringVelocity: 1.0,
////            options: .curveEaseInOut,
////            animations: {
////                self.transparentView.alpha = 0
////                //            self.tableView.frame = CGRect(
////                //                x: frames.origin.x,
////                //                y: frames.origin.y + frames.height,
////                //                width: frames.width,
////                //                height: 0
////                //            )
////                self.tableView.snp.updateConstraints { make in
////                    make.height.equalTo(0)
////                }
////        }, completion: nil)
//    }
    
    @objc private func onClickToChooseGenderButton() {
        
        let vc = DropdownViewController()
        vc.delegate = self
        vc.dropdownType = .gender
        present(vc, animated: true)
//        selectedButton = chooseGenderButton
//        addTransparentView(frames: chooseGenderButton.frame)
    }
    
    @objc private func onClickToChooseProvinesButton() {
        let vc = DropdownViewController()
        vc.delegate = self
        vc.dropdownType = .provines
        present(vc, animated: true)
//        selectedButton = chooseProvinesButton
//        addTransparentView(frames: chooseGenderButton.frame)
    }
    
    @objc private func onClickToLoginButton() {
        login()
    }
}

extension SignUpViewController: DropdownViewControllerDelegate {
    func selectedDropdown(_ id: String, dropdownType: Dropdown, title: String) {
        
        switch dropdownType {
        case .gender:
            chooseGenderButton.setTitle(id, for: .normal)
        
        case .provines:
            chooseProvinesButton.setTitle(title, for: .normal)
            
        default:
            break
        }
    }

}
