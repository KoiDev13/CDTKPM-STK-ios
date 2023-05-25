//
//  ServiceTableViewCell.swift
//  DA_CDTKPMNC
//
//  Created by Hoang Son Vo Phuoc on 5/23/23.
//

import UIKit
import Kingfisher

class ServiceTableViewCell: UITableViewCell, ReusableView {
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.addShadow()
        return view
    }()
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.text = "Nâng cơ Hifu Linear 6D"
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.textColor = UIColor(hex: "#797979")
        label.text = "Horem ipsum dolor sit amet, consectetur adipiscing elit"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupView()
    }
    
    override func prepareForReuse() {
        productImageView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(containerView)
        containerView.addSubview(productImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(contentLabel)
        
        
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.right.equalToSuperview().inset(12)
            make.bottom.equalToSuperview()
        }
        
        productImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.size.equalTo(80)
            make.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(productImageView.snp.right).offset(12)
            make.top.equalToSuperview().offset(4)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(titleLabel.snp.bottom)
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
        
    }
    
    func setupViewModel(_ store: Store) {
        
        titleLabel.text = store.name ?? ""
        
        contentLabel.text = store.description ?? ""
        
        guard let urlString = store.bannerURL,
                let url = URL(string: "http://api.vovanthuong.online\(urlString)") else {
            return
        }
        
        productImageView.kf.setImage(with: url)
    }
}

extension UIView {
    
    func addShadow() {
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.07).cgColor
        layer.shadowOffset = .zero
        layer.shadowOpacity = 1
        layer.shadowRadius = 12
    }
}
