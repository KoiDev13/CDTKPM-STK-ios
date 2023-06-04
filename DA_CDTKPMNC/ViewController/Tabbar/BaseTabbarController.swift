//
//  BaseTabbarController.swift
//  DA_CDTKPMNC
//
//  Created by Hoang Son Vo Phuoc on 5/9/23.
//

import UIKit

protocol BaseTabbarControllerDelegate: AnyObject {
    func didSignoutSuccessfully()
}

final class BaseTabbarController: UITabBarController {

    init(subDelegate: BaseTabbarControllerDelegate?) {
        self.subDelegate = subDelegate
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    weak var subDelegate: BaseTabbarControllerDelegate?

    private lazy var indicatorPlatform: UIView = {
        let view = UIView()
        return view
    }()

    private lazy var initViewController: [UIViewController] = {
        let homeVC = HomeViewController()
        homeVC.tabBarItem = TabBarItem(
            title: "Points",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        let homeNavi = UINavigationController(rootViewController: homeVC)
        
        let listVoucher = ListVoucherViewController()
        listVoucher.tabBarItem = TabBarItem(
            title: "Voucher",
            image: UIImage(systemName: "list.bullet.clipboard"),
            selectedImage: UIImage(systemName: "list.clipboard.fill")
        )
        let listVoucherNavi = UINavigationController(rootViewController: listVoucher)

        let profileVC = ProfileViewController()
        profileVC.delegate = self
        profileVC.tabBarItem = TabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person.crop.circle"),
            selectedImage: UIImage(systemName: "person.crop.circle.fill")
        )
        let profileNavi = UINavigationController(rootViewController: profileVC)

        return [homeNavi, listVoucherNavi, profileNavi]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .white

        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.normal.iconColor = UIColor.black.withAlphaComponent(0.5)
        itemAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.black.withAlphaComponent(0.5),
            .font: UIFont.systemFont(ofSize: 10)
        ]
//        itemAppearance.selected.iconColor = UIColor(resource: R.color.primary_color)
//        itemAppearance.selected.titleTextAttributes = [
//            .foregroundColor: UIColor(resource: R.color.primary_color) ?? UIColor.black.withAlphaComponent(0.5),
//            .font: UIFont.systemFont(ofSize: 10)
//        ]
        appearance.stackedLayoutAppearance = itemAppearance
        appearance.inlineLayoutAppearance = itemAppearance
        appearance.compactInlineLayoutAppearance = itemAppearance
        tabBar.standardAppearance = appearance
        tabBar.isTranslucent = false
        tabBar.backgroundColor = .white

        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: tabBar.frame.size.width, height: 1))
        lineView.backgroundColor = UIColor(hex: "#3C3C43").withAlphaComponent(0.36)
        tabBar.addSubview(lineView)

        viewControllers = initViewController
        setupIndicatorPlatform()
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let index = CGFloat(integerLiteral: tabBar.items!.firstIndex(of: item)!)
        let itemWidth = tabBar.frame.width / CGFloat(tabBar.items!.count)
        let newCenterX = (itemWidth / 2) + (itemWidth * index)

        indicatorPlatform.backgroundColor = .clear

        UIView.animate(withDuration: 0.3) {
            if let tabBarItem = item as? TabBarItem,
               let tabBarItemColor = tabBarItem.tintColor {
                tabBar.tintColor = tabBarItemColor
            }
            self.indicatorPlatform.backgroundColor = .clear
            self.indicatorPlatform.center.x = newCenterX
        }
    }


    private func setupIndicatorPlatform() {
        let tabBarItemSize = CGSize(width: tabBar.frame.width / CGFloat(tabBar.items!.count), height: tabBar.frame.height)
        indicatorPlatform.frame = CGRect(x: 0.0, y: 0.0, width: tabBarItemSize.width - 25, height: 4.0)
        indicatorPlatform.backgroundColor = .clear
        indicatorPlatform.layer.cornerRadius = 4
        indicatorPlatform.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        indicatorPlatform.center.x = tabBar.frame.width / CGFloat(tabBar.items!.count) / 2.0
        tabBar.addSubview(indicatorPlatform)
    }

}

extension BaseTabbarController: ProfileViewControllerDelegate {
    func didLogoutSuccessfully() {
        selectedIndex = 0
        subDelegate?.didSignoutSuccessfully()
    }
    
   
}

final class TabBarItem: UITabBarItem {
    
    var tintColor: UIColor?
    
    convenience init(title: String?, image: UIImage?, tag: Int) {
        self.init()
        
        super.title = title
        super.image = image
        super.tag = tag
    }
    
    convenience init(title: String?, image: UIImage?, selectedImage: UIImage?)  {
        self.init()
        
        super.title = title
        super.image = image
        super.selectedImage = selectedImage
    }
}
