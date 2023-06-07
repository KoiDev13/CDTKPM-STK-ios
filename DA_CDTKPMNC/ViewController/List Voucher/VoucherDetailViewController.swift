//
//  VoucherDetailViewController.swift
//  DA_CDTKPMNC
//
//  Created by Hoang Son Vo Phuoc on 6/4/23.
//

import UIKit

class VoucherDetailViewController: UIViewController {
    
    var voucher: Voucher?
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.addShadow()
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = UIColor(hex: "#797979")
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(contentLabel)
        view.addSubview(containerView)
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(50)
            make.size.equalTo(300)
            make.centerX.equalToSuperview()
        }
        
        let rightButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(rightButtonTapped))
        navigationItem.rightBarButtonItem = rightButton
        
        titleLabel.text = voucher?.voucherName?.capitalized
        
        contentLabel.text = voucher?.description?.capitalized
        
        let myString = voucher?.voucherCode ?? ""
        
        if let qrCodeImage = generateQRCode(from: myString) {
            let qrCodeImageView = UIImageView(image: qrCodeImage)
            qrCodeImageView.contentMode = .scaleAspectFit
            
            containerView.addSubview(qrCodeImageView)
            
            qrCodeImageView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        } else {
            print("Failed to generate QR code.")
        }
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 10, y: 10)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                let context = CIContext(options: nil)
                if let cgImage = context.createCGImage(output, from: output.extent) {
                    let qrCodeImage = UIImage(cgImage: cgImage)
                    return qrCodeImage
                }
            }
        }
        
        return nil
    }
    
    @objc func rightButtonTapped() {
        let alertController = UIAlertController(
            title: "Share voucher",
            message: nil,
            preferredStyle: .alert
        )
        
        alertController.addTextField { textField in
            textField.placeholder = "To email"
        }
        
        let sendAction = UIAlertAction(
            title: "Send",
            style: .default
        ) { _ in
            if let textField = alertController.textFields?.first {
                if let message = textField.text {
                    self.sendMessage(message)
                }
            }
        }
        
        alertController.addAction(sendAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func sendMessage(_ message: String) {
        
        guard let voucherCode = voucher?.voucherCode else {
            return
        }
        
        NetworkManager.shared.shareVoucher(voucherCode: voucherCode, email: message) { [weak self] result in
            
            guard let self = self else {
                return
            }
            
            switch result {
                
            case .success(let response):
                
                let success = response.success ?? false
                
                let message = response.message ?? ""
                
                if success {
                    self.showMessage(message, title: "Notify")
                } else {
                    self.showAlert("Share voucher not successfuly")
                }
                
            case .failure(let error):
                self.showAlert(error.localizedDescription)
            }
        }
    }
    
    


}
