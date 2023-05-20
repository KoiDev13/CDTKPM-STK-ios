//
//  SMSConfirmationViewController.swift
//  DA_CDTKPMNC
//
//  Created by Hoang Son Vo Phuoc on 5/12/23.
//

import UIKit

protocol SMSConfirmationViewControllerDelegate: AnyObject {
    func didLoginSuccessfully()
}
class SMSConfirmationViewController: UIViewController {
    
    weak var delegate: SMSConfirmationViewControllerDelegate?
    
    var userId: String = ""

    private lazy var verifyCodeView: OTPStackView = {
        let verifyCodeView = OTPStackView()
        verifyCodeView.delegate = self
        return verifyCodeView
    }()
    
    private lazy var resendCodeButton: PrimaryButton = {
        let button = PrimaryButton()
        button.addTarget(self,
                         action: #selector(onClickToResendCodeButton),
                         for: .touchUpInside)
        button.configure("Verify",
                         backgroundColor: UIColor.App.primaryDarkBlueButton,
                         font: UIFont.systemFont(ofSize: 12))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.App.primaryBackground
        
        view.addSubview(verifyCodeView)
        view.addSubview(resendCodeButton)
        
        verifyCodeView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(56)
        }
        verifyCodeView.becomeFirstResponder()
        
        resendCodeButton.snp.makeConstraints { make in
            make.top.equalTo(verifyCodeView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(56)
        }
    }
    
    @objc func onClickToResendCodeButton() {
        
        debugPrint("userId: \(userId)")
        
        NetworkManager.shared.verifyOTP(userId: userId, otp: Int(verifyCodeView.getOTPString())!) { result in
            switch result {
                
            case .success(let user):
                LocalStorageManager.shared.saveUser(user.data)
                LocalStorageManager.shared.updateCredential(user.data?.token?.accessToken ?? "")
                
                self.delegate?.didLoginSuccessfully()
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SMSConfirmationViewController: OTPStackViewDelegate {
    func didChangeValidity(isValid: Bool) {
        debugPrint(isValid)
//        if isValid {
//            UIHelper.showServiceLoading()
//
//            let otp = verifyCodeView.code
//
//            viewModel.verifyOTP(phoneNumber: viewModel.phoneNumber,
//                                phoneCountryCode: viewModel.phoneCode,
//                                otp: otp) { [weak self] result in
//                guard let self = self else {
//                    return
//                }
//
//                UIHelper.hideServiceLoading()
//
//                switch result {
//                case .success(let response):
//                    if response.data ?? false{
//                        self.switchToSignUp()
//                    } else {
//                        self.shouldShowErrorLabel(isShow: true)
//                    }
//                case .failure(let error):
//                    debugPrint(error.localizedDescription)
//                }
//            }
//        } else {
//            shouldShowErrorLabel(isShow: false)
//        }
    }
}

protocol OTPStackViewDelegate: AnyObject {
    func didChangeValidity(isValid: Bool)
}

class OTPStackView: UIStackView {

    var textFieldArray = [OTPTextField]()
    var numberOfOTPdigit = 6

    weak var delegate: OTPStackViewDelegate?
    
//    var showsWarningColor = false {
//        didSet {
//            textFieldArray.forEach {
//                $0.addUnderLine(with: UIColor(hex: showsWarningColor ? "#C35C45" : "#F4B836"))
//                $0.textColor = UIColor(hex: showsWarningColor ? "#C35C45" : "#F4B836")
//            }
//        }
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupStackView()
        setTextFields()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupStackView()
        setTextFields()
    }

    private func setupStackView() {
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = true
        self.contentMode = .center
        self.distribution = .fillEqually
        self.spacing = 16
    }

    private func setTextFields() {

        for i in 0..<numberOfOTPdigit {
            let field = OTPTextField()
            setupTextField(field)
            textFieldArray.append(field)
            i != 0 ? (field.previousTextField = textFieldArray[i-1]) : ()
            i != 0 ? (textFieldArray[i-1].nextTextFiled = textFieldArray[i]) : ()
        }
        textFieldArray[0].becomeFirstResponder()
    }
    
    
    private func setupTextField(_ textField: OTPTextField) {
        textField.delegate = self
        addArrangedSubview(textField)
        textField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(self.snp.height)
            make.width.equalTo(40)
        }
        textField.backgroundColor = .white
        textField.textAlignment = .center
        textField.textColor = UIColor(hex: "#F4B836")
        textField.keyboardType = .phonePad
        textField.autocorrectionType = .yes
        textField.textContentType = .oneTimeCode
//        textField.addUnderLine(with: UIColor(hex: "#F4B836"))
    }
    
    private func checkForValidity(){
        for fields in textFieldArray{
            if (fields.text?.trimmingCharacters(in: CharacterSet.whitespaces) == ""){
                delegate?.didChangeValidity(isValid: false)
                return
            }
        }
        delegate?.didChangeValidity(isValid: true)
    }
    
    func getOTPString() -> String {
        var OTP = ""
        for textField in textFieldArray{
            OTP += textField.text ?? ""
        }
        return OTP
    }
    
    
}

extension OTPStackView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        if showsWarningColor {
//            showsWarningColor = false
//        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkForValidity()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range:NSRange,
                   replacementString string: String) -> Bool {
        
        guard let field = textField as? OTPTextField else {
            return true
        }
        if !string.isEmpty {
            field.text = string
            field.resignFirstResponder()
            field.nextTextFiled?.becomeFirstResponder()
            return true
        }
        return true
    }
}

class OTPTextField: UITextField {
    var previousTextField: UITextField?
    var nextTextFiled: UITextField?

    override func deleteBackward() {
        if text == "" {
            previousTextField?.becomeFirstResponder()
            previousTextField?.text = ""
            return
        }
        text = ""
    }
}
