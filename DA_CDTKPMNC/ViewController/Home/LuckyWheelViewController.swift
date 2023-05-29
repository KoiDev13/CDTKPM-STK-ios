//
//  LuckyWheelViewController.swift
//  DA_CDTKPMNC
//
//  Created by Hoang Son Vo Phuoc on 5/16/23.
//

import UIKit
import iOSLuckyWheel

class LuckyWheelViewController: UIViewController, LuckyWheelDataSource,LuckyWheelDelegate {

    var wheel :LuckyWheel?
    var items = [WheelItem]()
    
    var campaignID = ""
    
    var store: Store?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        wheel = LuckyWheel(frame: CGRect(x: 0, y: 0, width: view.frame.width / 2 , height: 300))
        wheel?.delegate = self
        wheel?.dataSource = self
        wheel?.center = self.view.center
        wheel?.infinteRotation = true
        
        view.addSubview(wheel!)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            
            self.fetchData()
        }
        
//        wheel?.addTarget(self, action: #selector(wheelTapped), for: .touchUpInside)
       
    }
    
//    @objc func wheelTapped() {
//        wheel.rota
//    }
    
    private func fetchData() {
        NetworkManager.shared.getGameLuckyWheel(campaignID: campaignID) { [weak self] result in
            
            guard let self = self else {
                return
            }
            
            self.wheel?.stop()
            
            switch result {
                
            case .success(let response):
                
                let isWinner = response.data?.isWinner ?? false
                
                if isWinner {
                    self.showMessage(response.data?.voucher?.voucherName ?? "", title: "Thông báo") {
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                } else {
                    self.showMessage("Chúc bạn may mắn lần sau", title: "Thông báo") {
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                }
                
            case .failure(let error):
                self.showAlert(error.localizedDescription) {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    func numberOfSections() -> Int {
        return store?.campaign?.campaignVoucherList?.count ?? 0
    }
    
    func randomColor() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        let alpha = CGFloat.random(in: 0.5...1) // Optional: You can adjust the alpha value range
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    func itemsForSections() -> [WheelItem] {
        
        store?.campaign?.campaignVoucherList?.forEach {
            
            items.append(WheelItem(title: $0.name ?? "", titleColor: .white, itemColor: randomColor()))
            
        }
        
        return items
    }
    
    func wheelDidChangeValue(_ newValue: Int) {
        print(newValue)
    }

}

extension UIViewController {

    func showAlert(_ message: String, completionHandler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .cancel, handler: { _ in
            completionHandler?()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func showMessage(_ message: String, title: String, completionHandler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .cancel, handler: { _ in
            completionHandler?()
        }))
        present(alert, animated: true, completion: nil)
    }
}
