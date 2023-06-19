//
//  LoginViewController.swift
//  DA_CDTKPMNC
//
//  Created by Hoang Son Vo Phuoc on 5/7/23.
//

import UIKit
import SnapKit
import BonMot

protocol LoginViewControllerDelegate: AnyObject {
    func didLoginSuccessfully()
}

class LoginViewController: UIViewController {

    let viewModel: LoginViewModel
    
    weak var delegate: LoginViewControllerDelegate?
    
    init(viewModel: LoginViewModel = .init()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    private lazy var logoImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "ic_logo_mini")
//        imageView.contentMode = .scaleToFill
//        imageView.clipsToBounds = true
//        return imageView
//    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome back!"
        label.numberOfLines = 0
        label.textColor = UIColor.App.secondaryTitle
        label.font = UIFont.systemFont(ofSize: 40)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
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
    
    private lazy var emailTextField: PrimaryTextField = {
        let textField = PrimaryTextField()
        textField.autocapitalizationType = .none
        textField.configure("Your email ")
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
    
    private lazy var loginButton: PrimaryButton = {
        let button = PrimaryButton()
        button.configure("Login",
                         titleColor: .white,
                         backgroundColor: UIColor.App.primaryButton,
                         font: UIFont.systemFont(ofSize: 16))
        button.addTarget(self,
                         action: #selector(onClickToLoginButton),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var signupButton: SecondaryButton = {
        let button = SecondaryButton()
        button.configure("Sign up",
                         backgroundColor: .clear,
                         font: UIFont.systemFont(ofSize: 16),
                         borderColor: UIColor.App.secondaryOnDarkBlue,
                         titleColor: UIColor.App.primaryOnDarkBlue)
        button.addTarget(self,
                         action: #selector(onClickToSignUpButton),
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
        
//        containerView.addSubview(logoImageView)
//        logoImageView.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(50)
//            make.centerX.equalToSuperview()
//        }
    
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
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
        
        containerView.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(18)
            make.height.equalTo(50)
        }
        
        containerView.addSubview(signupButton)
        signupButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(18)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-50)
        }
    }
    
    private func login() {
        
        guard let username = emailTextField.text else {
            return
        }
        
        guard let password = passwordTextField.text else {
            return
        }
        
        viewModel.login(username: username, password: password) { [weak self] result in
            
            guard let self = self else {
                return
            }
            
            switch result {
                
            case .success(_):
                
                self.delegate?.didLoginSuccessfully()
                
            case .failure(let error):
                
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    
    @objc private func onClickToSignUpButton() {
        let vc = SignUpViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func onClickToLoginButton() {
        login()
    }

}


extension LoginViewController: SignUpViewControllerDelegate {
    func didSignUpSuccessfully() {
        delegate?.didLoginSuccessfully()
    }
    
    
}
final class PrimaryButton: UIButton {
    
    let cornerRadius: CGFloat = 12
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = cornerRadius
    }
    
    func configure(_ title: String,
                   titleColor: UIColor = .white,
                   backgroundColor: UIColor,
                   font: UIFont) {
        setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
        setTitleColor(titleColor, for: .normal)
        titleLabel?.font = font
    }
}

final class SecondaryButton: UIButton {
    
    let cornerRadius: CGFloat = 12
    
    let borderWidth: CGFloat = 1
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
    }
    
    func configure(_ title: String,
                   backgroundColor: UIColor,
                   font: UIFont,
                   borderColor: UIColor,
                   titleColor: UIColor) {
        setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
        titleLabel?.font = font
        layer.borderColor = borderColor.cgColor
        setTitleColor(titleColor, for: .normal)
    }
}

final class PrimaryTextField: UITextField {
    
    let cornerRadius: CGFloat = 12
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderColor = UIColor.clear.cgColor
        layer.cornerRadius = cornerRadius
        backgroundColor = UIColor.App.primaryTextField
        textColor = UIColor.App.secondaryTitle
    }
    
    func configure(_ placeholder: String) {
        let paddingView = UIView(frame: CGRect(x: 0,
                                               y: 0,
                                               width: 15,
                                               height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
        self.attributedPlaceholder = placeholder.styled(with: .color(UIColor.App.primaryPlaceholderTextField), .font(UIFont.systemFont(ofSize: 13)))
        self.font = UIFont.systemFont(ofSize: 13)
    }
}
