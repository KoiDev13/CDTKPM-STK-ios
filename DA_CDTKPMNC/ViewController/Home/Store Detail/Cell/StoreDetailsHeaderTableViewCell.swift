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

class ListDoctorTableViewCell: UITableViewCell, ReusableView {

    var doctors: [ProductItem] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        let with = (UIScreen.main.bounds.width - 30) / 2
        layout.itemSize = CGSize(width: with, height: with * 1.25)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        collectionView.register(HomeDoctorCollectionViewCell.self)
        return collectionView
    }()
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
            self.collectionView.layoutIfNeeded()
            self.layoutIfNeeded()
            let contentSize = self.collectionView.collectionViewLayout.collectionViewContentSize
            return CGSize(width: contentSize.width, height: contentSize.height + 8)
        }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
}

extension ListDoctorTableViewCell: UICollectionViewDelegate {
    
}

extension ListDoctorTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return doctors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: HomeDoctorCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setupViewModel(doctors[indexPath.row])
        return cell
    }
    
    
}


class HomeDoctorCollectionViewCell: UICollectionViewCell, ReusableView {
    
    private var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var doctorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var namelabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var descriptionlabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        doctorImageView.image = nil
        namelabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        addSubview(containerView)
        containerView.addSubview(doctorImageView)
        containerView.addSubview(namelabel)
        containerView.addSubview(descriptionlabel)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        doctorImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(170)
        }
        
        namelabel.snp.makeConstraints { make in
            make.top.equalTo(doctorImageView.snp.bottom).offset(4)
            make.left.right.equalToSuperview()
        }
        
        descriptionlabel.snp.makeConstraints { make in
            make.top.equalTo(namelabel.snp.bottom).offset(4)
            make.left.right.equalToSuperview()
        }
    }
    
    func setupViewModel(_ product: ProductItem) {
        
        namelabel.text = product.name ?? ""
        descriptionlabel.text = product.description ?? ""
        
        guard let urlString = product.imageURL,
                let url = URL(string: "http://api.vovanthuong.online\(urlString)") else {
            return
        }
        
        doctorImageView.kf.setImage(with: url)
    }
}
