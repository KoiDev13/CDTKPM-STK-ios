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

protocol SignUpViewControllerDelegate: AnyObject {
    func didSignUpSuccessfully()
}
class SignUpViewController: UIViewController {
    
    weak var delegate: SignUpViewControllerDelegate?
    
    var selectedProvines: String?
    var selectedDistrict: String?
    var selectedWard: String?
    var selectedGender: Int?
    
    var selectedDay: Int?
    var selectedMounth: Int?
    var selectedYears: Int?
    
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
    
    private lazy var chooseDistrictButton: SecondaryButton = {
        let button = SecondaryButton()
        button.configure("Choose districts",
                         backgroundColor: .clear,
                         font: UIFont.systemFont(ofSize: 16),
                         borderColor: UIColor.App.secondaryOnDarkBlue,
                         titleColor: UIColor.App.primaryOnDarkBlue)
        button.addTarget(self,
                         action: #selector(onClickToChooseDistrictsButton),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var chooseWardsButton: SecondaryButton = {
        let button = SecondaryButton()
        button.configure("Choose wards",
                         backgroundColor: .clear,
                         font: UIFont.systemFont(ofSize: 16),
                         borderColor: UIColor.App.secondaryOnDarkBlue,
                         titleColor: UIColor.App.primaryOnDarkBlue)
        button.addTarget(self,
                         action: #selector(onClickToChooseWardsButton),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var backButton: SecondaryButton = {
        let button = SecondaryButton()
        button.configure("Back",
                         backgroundColor: .clear,
                         font: UIFont.systemFont(ofSize: 16),
                         borderColor: UIColor.App.secondaryOnDarkBlue,
                         titleColor: UIColor.App.primaryOnDarkBlue)
        button.addTarget(self,
                         action: #selector(onClickToBackButton),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var addressTextField: PrimaryTextField = {
        let textField = PrimaryTextField()
        textField.autocapitalizationType = .none
        textField.configure("Your address ")
        textField.font = UIFont.systemFont(ofSize: 16)
        return textField
    }()
    
    private lazy var dateOfBirthTextField: PrimaryTextField = {
        let textField = PrimaryTextField()
        textField.configure("DD/MM/YYYY ")
        textField.datePicker(target: self,
                             doneAction: #selector(doneAction),
                             datePickerMode: .date)
        return textField
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
        
        containerView.addSubview(dateOfBirthTextField)
        dateOfBirthTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(18)
            make.height.equalTo(56)
        }
        
        containerView.addSubview(chooseGenderButton)
        chooseGenderButton.snp.makeConstraints { make in
            make.top.equalTo(dateOfBirthTextField.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(18)
            make.height.equalTo(50)
        }
        
        containerView.addSubview(chooseProvinesButton)
        chooseProvinesButton.snp.makeConstraints { make in
            make.top.equalTo(chooseGenderButton.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(18)
            make.height.equalTo(50)
        }
        
        containerView.addSubview(chooseDistrictButton)
        chooseDistrictButton.snp.makeConstraints { make in
            make.top.equalTo(chooseProvinesButton.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(18)
            make.height.equalTo(50)
        }
        
        containerView.addSubview(chooseWardsButton)
        chooseWardsButton.snp.makeConstraints { make in
            make.top.equalTo(chooseDistrictButton.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(18)
            make.height.equalTo(50)
        }
        
        containerView.addSubview(addressTextField)
        addressTextField.snp.makeConstraints { make in
            make.top.equalTo(chooseWardsButton.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(18)
            make.height.equalTo(56)
        }
        
        containerView.addSubview(signupButton)
        signupButton.snp.makeConstraints { make in
            make.top.equalTo(addressTextField.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(18)
            make.height.equalTo(50)
            
        }
        
        containerView.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(signupButton.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(18)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-50)
        }
    }
    
    private func signUp() {
        
        guard let email = emailTextField.text else {
            return
        }
        
        guard let password = passwordTextField.text else {
            return
        }
        
        guard let comfirmPassword = confirmPasswordTextField.text else {
            return
        }
        
        guard let name = nameTextField.text else {
            return
        }
        
        guard let address = addressTextField.text else {
            return
        }
        
        guard let dob = dateOfBirthTextField.text else {
            return
        }
        
        guard let gender = selectedGender else {
            return
        }
        
        guard let wardID = selectedWard else {
            return
        }
        
        let user = SignUpModel(userName: email,
                               password: password,
                               name: name,
                               gender: gender,
                               dateOfBirth: .init(year: selectedYears ?? 0,
                                                month: selectedMounth ?? 0,
                                                day: selectedDay ?? 0),
                               address: .init(wardID: wardID,
                                              street: address))
        NetworkManager.shared.signup(user) { result in
            switch result {
            case .success(let user):
                debugPrint(user)
                let vc = SMSConfirmationViewController()
                vc.delegate = self
                vc.userId = user.data?.account?.id ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    @objc private func doneAction() {
        
        if let datePickerView = dateOfBirthTextField.inputView as? UIDatePicker {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            
            let dateString = dateFormatter.string(from: datePickerView.date)
            
            dateOfBirthTextField.text = dateString
            dateOfBirthTextField.resignFirstResponder()
            
            let components = datePickerView.calendar.dateComponents([.day, .month, .year],
                                                                    from: datePickerView.date)
            let day = components.day
            let month = components.month
            let year = components.year
            
            selectedDay = day
            selectedMounth = month
            selectedYears = year
            //            checkInvalidInput()
        }
    }
    
    @objc private func onClickToChooseGenderButton() {
        
        let vc = DropdownViewController()
        vc.delegate = self
        vc.dropdownType = .gender
        present(vc, animated: true)
    }
    
    @objc private func onClickToChooseProvinesButton() {
        let vc = DropdownViewController()
        vc.delegate = self
        vc.dropdownType = .provines
        present(vc, animated: true)
    }
    
    @objc private func onClickToChooseDistrictsButton() {
        let vc = DropdownViewController()
        vc.delegate = self
        vc.dropdownType = .districts
        vc.selectedProvines = selectedProvines
        present(vc, animated: true)
    }
    
    @objc private func onClickToChooseWardsButton() {
        let vc = DropdownViewController()
        vc.delegate = self
        vc.dropdownType = .wards
        vc.selectedDistrict = selectedDistrict
        present(vc, animated: true)
    }
    
    @objc private func onClickToLoginButton() {
        
       
        signUp()
    }
    
    @objc private func onClickToBackButton() {
        navigationController?.popViewController(animated: true)
    }
}

extension SignUpViewController: DropdownViewControllerDelegate {
    func selectedDropdown(_ id: String, dropdownType: Dropdown, title: String) {
        
        switch dropdownType {
        case .gender:
            chooseGenderButton.setTitle(id, for: .normal)
            selectedGender = id == "Male" ? 0 : 1
        case .provines:
            chooseProvinesButton.setTitle(title, for: .normal)
            selectedProvines = id
            
        case .districts:
            chooseDistrictButton.setTitle(title, for: .normal)
            selectedDistrict = id
            
        case .wards:
            chooseWardsButton.setTitle(title, for: .normal)
            selectedWard = id
        default:
            break
        }
    }
    
}

extension SignUpViewController: SMSConfirmationViewControllerDelegate {
    func didLoginSuccessfully() {
        delegate?.didSignUpSuccessfully()
    }
    
    
}

extension UITextField {
    
    func datePicker<T>(target: T,
                       doneAction: Selector,
                       datePickerMode: UIDatePicker.Mode = .date) {
        let screenWidth = UIScreen.main.bounds.width
        
        func buttonItem(withSystemItemStyle style: UIBarButtonItem.SystemItem) -> UIBarButtonItem {
            let buttonTarget = style == .flexibleSpace ? nil : target
            let action: Selector? = {
                switch style {
                case .done:
                    return doneAction
                default:
                    return nil
                }
            }()
            
            let barButtonItem = UIBarButtonItem(barButtonSystemItem: style,
                                                target: buttonTarget,
                                                action: action)
            
            return barButtonItem
        }
        
        let datePicker = UIDatePicker(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width: screenWidth,
                                                    height: 216))
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.datePickerMode = datePickerMode
        datePicker.maximumDate = Date()
        self.inputView = datePicker
        
        let toolBar = UIToolbar(frame: CGRect(x: 0,
                                              y: 0,
                                              width: screenWidth,
                                              height: 44))
        toolBar.setItems([buttonItem(withSystemItemStyle: .flexibleSpace),
                          buttonItem(withSystemItemStyle: .done)],
                         animated: true)
        self.inputAccessoryView = toolBar
    }
}


