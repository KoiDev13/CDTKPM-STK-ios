//
//  HomeViewController.swift
//  DA_CDTKPMNC
//
//  Created by Hoang Son Vo Phuoc on 5/9/23.
//

import UIKit

class HomeViewController: UIViewController {

    let viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel = .init()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 150
        tableView.backgroundColor = .clear
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.automaticallyAdjustsScrollIndicatorInsets = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.register(ServiceTableViewCell.self)
        return tableView
    }()
    
    private lazy var badgeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .red
        label.font = UIFont.systemFont(ofSize: 12)
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        getAllStore()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateNotificationBadge()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        let buttonItem = UIBarButtonItem()
        
        // Create a custom view for the button
        let containerView = UIView()
        
        // Create the bell icon image view
        let bellImageView = UIImageView(image: UIImage(systemName: "bell")) // Replace "bell-icon" with the actual name of your bell icon image
        
        // Add the bell icon and badge label to the container view
        containerView.addSubview(bellImageView)
        containerView.addSubview(badgeLabel)
        
        // Add a target action to the button
        containerView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(bellButtonTapped))
        containerView.addGestureRecognizer(tapGesture)
        
        // Set the container view as the custom view for the UIBarButtonItem
        buttonItem.customView = containerView
        
        // Set the UIBarButtonItem as the right bar button item for your navigation bar
        navigationItem.rightBarButtonItem = buttonItem
        
        // Apply SnapKit constraints
        containerView.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        bellImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        badgeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(-5)
            make.trailing.equalToSuperview().offset(6)
            make.width.height.equalTo(20)
        }
    }
    
    @objc private func bellButtonTapped() {
        let vc = ListNotificationViewController()
        vc.notifications = viewModel.notifications
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func getAllStore() {
        
        viewModel.getAllStore { [weak self] result in
        
            guard let self = self else {
                return
            }
            
            switch result {
                
            case .success(_):
                self.tableView.reloadData()
                
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    private func updateNotificationBadge() {
        
        NetworkManager.shared.getNotifications { [weak self] result in
            
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let response):
                
                let numberUnread = response.data?.notications?.numberUnread ?? 0
                
                self.updateBadgeLabel(numberUnread)
                
                self.viewModel.notifications = response.data?.notications?.notications ?? []
                
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }

    private func updateBadgeLabel(_ numberUnread: Int) {
        badgeLabel.isHidden = (numberUnread == 0)
        badgeLabel.text = String(numberUnread)
    }
    
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = StoreDetailViewController(
            viewModel: .init(
                store: viewModel.itemAtIndex(
                    indexPath.row
                )
            )
        )
        
        navigationController?.pushViewController(vc, animated: true)
        
//        switch indexPath.row {
//        case 0:
//            let vc = DiceeGameViewController()
//            navigationController?.pushViewController(vc, animated: true)
//        default:
//            let vc = LuckyWheelViewController()
//            navigationController?.pushViewController(vc, animated: true)
//        }
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItem()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ServiceTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setupViewModel(viewModel.itemAtIndex(indexPath.row))
        return cell
    }
    
    
}



protocol ReusableView: AnyObject {
    static var defaultReuseIdentifier: String { get }
}

protocol NibLoadableView: AnyObject {
    static var nibName: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}

//Confirming Collection View and TableView for Registering and Dequeing
extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView {
        register(T.self, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView, T: NibLoadableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    //Registering Supplementary View
    
    func register<T: UICollectionReusableView>(_: T.Type, supplementaryViewOfKind: String) where T: ReusableView {
        register(T.self, forSupplementaryViewOfKind: supplementaryViewOfKind, withReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func register<T: UICollectionReusableView>(_: T.Type, supplementaryViewOfKind: String) where T: ReusableView, T: NibLoadableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        register(nib, forSupplementaryViewOfKind: supplementaryViewOfKind, withReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    //Dequeing
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind: String, indexPath: IndexPath) -> T where T: ReusableView {
        guard let supplementaryView = dequeueReusableSupplementaryView(ofKind: ofKind, withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue supplementary view with identifier: \(T.defaultReuseIdentifier)")
        }
        return supplementaryView
    }
}

extension UITableView {
    
    //Registering Cell
    func register<T: UITableViewCell>(_: T.Type) where T: ReusableView {
        register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func register<T: UITableViewCell>(_: T.Type) where T: ReusableView, T: NibLoadableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        register(nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    //Registering HeaderFooterView
    
    func register<T: UITableViewHeaderFooterView>(_: T.Type) where T: ReusableView {
        register(T.self, forHeaderFooterViewReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func register<T: UITableViewHeaderFooterView>(_: T.Type) where T: ReusableView, T: NibLoadableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        register(nib, forHeaderFooterViewReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    //Dequeing
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_ : T.Type) -> T where T: ReusableView {
        guard let headerFooter = dequeueReusableHeaderFooterView(withIdentifier: T.defaultReuseIdentifier) as? T else {
            fatalError("Could not dequeue Header/Footer with identifier: \(T.defaultReuseIdentifier)")
        }
        return headerFooter
    }
}
