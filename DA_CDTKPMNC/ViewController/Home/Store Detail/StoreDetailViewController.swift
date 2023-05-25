//
//  StoreDetailViewController.swift
//  DA_CDTKPMNC
//
//  Created by Hoang Son Vo Phuoc on 5/24/23.
//

import UIKit

class StoreDetailViewController: UIViewController {

    let viewModel: StoreDetailViewModel
    
    init(viewModel: StoreDetailViewModel) {
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
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.register(StoreDetailsHeaderTableViewCell.self)
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        canJoinPlayGame()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//            let vc = PopUpViewController(typeGame: .gameLuckyWhell)
//            self.add(vc)
//
//            vc.dismissActionHandler = {
//                vc.remove()
//            }
//        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0.0
        }
    }
    
    private func canJoinPlayGame() {
        
        guard let campaignID = viewModel.store.campaign?.id else {
            return
        }
        
        viewModel.canJoinPlayGame(campaignID: campaignID) { [weak self] result in
            
            guard let self = self else {
                return
            }
            
            switch result {
                
            case .success(_):
                if self.viewModel.isCanJoinGame {
                    
                    let gameName = self.viewModel.store.campaign?.gameName ?? ""
                    
                    if gameName == "Tài Xỉu" {
                        let vc = PopUpViewController(typeGame: .gameDicee)
                        self.add(vc)
                        
                        vc.dismissActionHandler = {
                            vc.remove()
                        }
                    } else {
                        let vc = PopUpViewController(typeGame: .gameLuckyWhell)
                        self.add(vc)
                        
                        vc.dismissActionHandler = {
                            vc.remove()
                        }
                    }
                }
                
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }

}

extension StoreDetailViewController: UITableViewDelegate {
    
}

extension StoreDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
       
        default:
            return 0
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell: StoreDetailsHeaderTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.delegate = self
            cell.setupViewModel(viewModel.store)
            return cell
       
        default:
            return UITableViewCell()
        }
    }
    
    
}

extension StoreDetailViewController: ProcedureDetailsDelegate {
    func popViewTap() {
        navigationController?.popViewController(animated: true)
    }
    
    
}
