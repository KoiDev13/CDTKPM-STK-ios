//
//  StoreDetailsHeaderTableViewCell.swift
//  DA_CDTKPMNC
//
//  Created by Hoang Son Vo Phuoc on 5/24/23.
//

import UIKit

protocol ProcedureDetailsDelegate: AnyObject {
    func popViewTap()
}

class StoreDetailsHeaderTableViewCell: UITableViewCell, ReusableView {

    weak var delegate: ProcedureDetailsDelegate?
    
    private lazy var procedureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(btnBackTapped(_:)), for: .touchUpInside)
        button.setImage(UIImage(systemName: "chevron.backward.circle.fill"), for: .normal)
        return button
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addShadow()
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 3
        return label
    }()
    
    ///MARK: - Setup UI
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(procedureImageView)
        contentView.addSubview(backButton)
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        
        procedureImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.left.right.equalToSuperview().offset(0)
            make.height.equalTo(270)
        }
        
        backButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(50)
            make.size.equalTo(28)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(procedureImageView.snp.bottom).offset(-50)
            make.left.right.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().offset(-12)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalToSuperview().inset(12)
        }
        
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().offset(-10)
        }
        
    }
    
    @objc func btnBackTapped(_ sender: UIButton) {
        delegate?.popViewTap()
    }
    
    func setupViewModel(_ store: Store) {
        
        titleLabel.text = store.name ?? ""
        descriptionLabel.text = store.description ?? ""
        
        guard let urlString = store.bannerURL,
                let url = URL(string: "http://api.vovanthuong.online\(urlString)") else {
            return
        }
        
        procedureImageView.kf.setImage(with: url)
    }
}
