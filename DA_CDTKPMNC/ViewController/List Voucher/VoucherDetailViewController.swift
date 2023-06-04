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
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
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
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(20)
            make.size.equalTo(300)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.text = voucher?.voucherName
        
        contentLabel.text = voucher?.description
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
