//
//  ListNotificationViewController.swift
//  DA_CDTKPMNC
//
//  Created by Hoang Son Vo Phuoc on 6/7/23.
//

import UIKit

//struct NotificationTest {
//    let id: String
//    let accountId: String?
//    let title: String?
//    let message: String?
//    let createAt: String?
//    var isRead: Bool?
//}

class ListNotificationViewController: UIViewController {

    

//    let notificationsData = [
//        [
//            "id": "254757f4-86b7-4361-c0ac-08db65113dcc",
//            "accountId": "aa6a367b-7004-4dbc-3b1a-08db6510eb16",
//            "title": "Received a gift from a friend",
//            "message": "You received a gift from a friend. Voucher code 50ab05f4-8951-4bce-af0e-667107c18878 | voucher A - Nước Ngọt Sửa | expine on 06/09/2023",
//            "createAt": "2023-06-05T15:09:31.0231956",
//            "isRead": false
//        ],
//        [
//            "id": "4eb50708-812a-4829-c0af-08db65113dcc",
//            "accountId": "aa6a367b-7004-4dbc-3b1a-08db6510eb16",
//            "title": "Received a gift from a friend",
//            "message": "You received a gift from a friend. Voucher code a58ecb32-760f-46ca-b891-ce412e3952e2 | voucher A sửa - Nước Ngọt Sửa | expine on 06/09/2023",
//            "createAt": "2023-06-05T15:15:12.6774628",
//            "isRead": false
//        ]
//    ]
    
    var notifications: [Notification] = []
    
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
        tableView.register(VoucherTableViewCell.self)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
//        for notificationData in notificationsData {
//            if let id = notificationData["id"] as? String,
//                let accountId = notificationData["accountId"] as? String,
//                let title = notificationData["title"] as? String,
//                let message = notificationData["message"] as? String,
//                let createAt = notificationData["createAt"] as? String,
//                let isRead = notificationData["isRead"] as? Bool {
//
//                let notification = NotificationTest(id: id, accountId: accountId, title: title, message: message, createAt: createAt, isRead: isRead)
//                notifications.append(notification)
//            }
//        }
//
//        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        self.navigationItem.title = "My Notifications"
    }
    
    private func markNotificationAsRead(_ id: String) {
        NetworkManager.shared.markNotificationAsRead(id: id) { [weak self] result in

            guard let self = self else {
                return
            }

            switch result {
                
            case .success(let response):
                
                let targetId = response.data?.notication?.id

                if let index = self.notifications.firstIndex(where: { $0.id == targetId }) {
                    self.notifications[index].isRead = true
                }
                
                self.tableView.reloadData()
                
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }

}

extension ListNotificationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        let targetId = notifications[indexPath.row].id

        markNotificationAsRead(targetId)
    }
}

extension ListNotificationViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: VoucherTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setupViewModelNotification(notifications[indexPath.row])
        return cell
    }
    
    
}
