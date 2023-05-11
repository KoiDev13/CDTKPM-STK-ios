//
//  MainFlowController.swift
//  DA_CDTKPMNC
//
//  Created by Hoang Son Vo Phuoc on 5/9/23.
//

import UIKit

protocol HomeFlowControllerDelegate: AnyObject {
    func didSignoutSuccessfully()
}

final class MainFlowController: BaseViewController, FlowController {
    
    enum Destination {
        case signup
        case home
    }
    
    private let navigation: UINavigationController
    
    private lazy var signUpViewController: LoginViewController = {
        let vc = LoginViewController()
        vc.delegate = self
        return vc
    }()
    
    private lazy var homeViewController: BaseTabbarController = {
        let vc = BaseTabbarController(subDelegate: self)
        return vc
    }()
    
    init(navigation: UINavigationController = UINavigationController()) {
        self.navigation = navigation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        add(navigation)
        initialLoading()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigation.setNavigationBarHidden(true, animated: false)
    }
    
    func navigate(to destination: Destination) {
        
        switch destination {
            
        case .signup:
            navigation.setViewControllers([signUpViewController], animated: false)
            
        case .home:
            navigation.setViewControllers([homeViewController], animated: false)
        }
    }
    
    private func initialLoading() {
        
        let credential = LocalStorageManager.shared.fetchCredential() ?? ""
        
        if credential.isEmpty {
            navigate(to: .signup)
        } else {
            navigate(to: .home)
        }
    }
    
   
}


extension MainFlowController: LoginViewControllerDelegate {
    func didLoginSuccessfully() {
        navigate(to: .home)
    }
}

extension MainFlowController: BaseTabbarControllerDelegate {
    func didSignoutSuccessfully() {
        navigate(to: .signup)
    }
}

extension UIViewController {
    
    func add(_ child: UIViewController) {
        view.addSubview(child.view)
        addChild(child)
        child.didMove(toParent: self)
        child.view.frame = self.view.bounds
    }
    
    func addCustom(_ child: UIViewController, topMargin: CGFloat) {
        view.addSubview(child.view)
        addChild(child)
        child.didMove(toParent: self)
        child.view.frame = CGRect(x: 0,
                                  y: topMargin,
                                  width: self.view.bounds.width,
                                  height: self.view.bounds.height - topMargin)
    }
    
    func remove() {
        guard parent != nil else {
            return
        }

        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
}
