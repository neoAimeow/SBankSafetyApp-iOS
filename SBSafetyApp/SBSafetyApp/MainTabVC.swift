//
//  MainTabVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/14.
//

import Foundation
import UIKit


class MainTabVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let title = ["首页", "消息", "工作台", "我的"]
        let home_VC = HomeVC()
        home_VC.tabBarItem = UITabBarItem.getHomeTab(withTitle: title[0])

        let msg_VC = ViewController()
        msg_VC.tabBarItem = UITabBarItem.getMsgTab(withTitle: title[1])

//        let wb_VC = WorkbenchVC()
//        wb_VC.tabBarItem = UITabBarItem.getWorkBenchTab(withTitle: title[2])

        let my_VC = MyVC()
        my_VC.tabBarItem = UITabBarItem.getMineTab(withTitle: title[3])


        let home_NC = UINavigationController(rootViewController: home_VC)   // 创建 home_NC 导航控制器
        let msg_NC = UINavigationController(rootViewController: msg_VC)   // 创建 msg_NC 导航控制器
//        let wb_NC = UINavigationController(rootViewController: wb_VC)   // 创建 wb_NC 导航控制器
        let my_NC = UINavigationController(rootViewController: my_VC)   // 创建 my_NC 导航控制器

        tabBar.tintColor = .primary  // 选中颜色
        tabBar.unselectedItemTintColor = .lightGray  // 未选中颜色
        tabBar.backgroundColor = .white
//        self.tabBar.backgroundImage = UIImage(color: .clear, size: CGSize(width: 200, height: 1))
//        self.tabBar.shadowImage = UIImage(color: .clear, size: CGSize(width: 200, height: 1))
//        self.viewControllers = [home_NC, msg_NC, wb_NC, my_NC]

        viewControllers = [home_NC, msg_NC, my_NC]
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var frame = self.tabBar.frame
        frame.size.height = 61 + CGFloat.safeAreaBottomHeight
        frame.origin.y = self.view.frame.size.height - frame.size.height
        self.tabBar.frame = frame
    }
}


class EngineerHomeVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let title = ["首页", "消息", "我的"]
        let home_VC = SEHomeVC() // TODO: 替换成维保页
        home_VC.tabBarItem = UITabBarItem.getHomeTab(withTitle: title[0])

        let msg_VC = ViewController()
        msg_VC.tabBarItem = UITabBarItem.getMsgTab(withTitle: title[1])

        let my_VC = MyVC()
        my_VC.tabBarItem = UITabBarItem.getMineTab(withTitle: title[2])

        let home_NC = UINavigationController(rootViewController: home_VC)   // 创建 home_NC 导航控制器
        let msg_NC = UINavigationController(rootViewController: msg_VC)   // 创建 msg_NC 导航控制器
        let my_NC = UINavigationController(rootViewController: my_VC)   // 创建 my_NC 导航控制器

        tabBar.tintColor = .primary  // 选中颜色
        tabBar.unselectedItemTintColor = .lightGray  // 未选中颜色
        tabBar.backgroundColor = .white

        viewControllers = [home_NC, msg_NC, my_NC]
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var frame = tabBar.frame
        frame.size.height = 61 + CGFloat.safeAreaBottomHeight
        frame.origin.y = view.frame.size.height - frame.size.height
        tabBar.frame = frame
    }
}

// MARK: - UITabBar Extension

private var isAnimating = false

extension UITabBar {
    func changeTabBar(hidden: Bool, animated: Bool) {
        if isAnimating {
            return
        }
        if self.isHidden == hidden {
            return
        }
        if self.isHidden {
            let y = UIScreen.main.bounds.height
            self.frame = CGRect(x: frame.minX, y: y, width: frame.width, height: frame.height)
        }

        let frame = self.frame
        let isOutScreen = Int(UIScreen.main.bounds.height - self.frame.minY) == 0
        let a: CGFloat = isOutScreen ? -1 : 1
        let offset = a * frame.size.height
        let duration: TimeInterval = (animated ? 0.5 : 0.0)

        self.isHidden = false
        isAnimating = true

        UIView.animate(withDuration: duration, animations: { self.center.y += offset }) { _ in
            self.isHidden = !isOutScreen
            isAnimating = false
        }
    }
}

extension UITabBarItem {
    class func getHomeTab(withTitle title: String) -> UITabBarItem {
        let tabBarItem = UITabBarItem(title: title, image: UIImage(named: "tab_home"), selectedImage: UIImage(named: "tab_home_h"))
        tabBarItem.setTitleTextAttributes(UITabBarItem.getAttri(), for: .normal)
        tabBarItem.setTitleTextAttributes(UITabBarItem.getSelAttri(), for: .selected)
        tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -8)
        return tabBarItem;
    }

    class func getMsgTab(withTitle title: String) -> UITabBarItem {
        let tabBarItem = UITabBarItem(title: title, image: UIImage(named: "tab_message"), selectedImage: UIImage(named: "tab_message_h"))
        tabBarItem.setTitleTextAttributes(UITabBarItem.getAttri(), for: .normal)
        tabBarItem.setTitleTextAttributes(UITabBarItem.getSelAttri(), for: .selected)
        tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -8)
        return tabBarItem;
    }

    class func getWorkBenchTab(withTitle title: String) -> UITabBarItem {
        let tabBarItem = UITabBarItem(title: title, image: UIImage(named: "tab_workbench"), selectedImage: UIImage(named: "tab_workbench_h"))
        tabBarItem.setTitleTextAttributes(UITabBarItem.getAttri(), for: .normal)
        tabBarItem.setTitleTextAttributes(UITabBarItem.getSelAttri(), for: .selected)
        tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -8)
        return tabBarItem;
    }

    class func getMineTab(withTitle title: String) -> UITabBarItem {
        let tabBarItem = UITabBarItem(title: title, image: UIImage(named: "tab_my"), selectedImage: UIImage(named: "tab_my_h"))
        tabBarItem.setTitleTextAttributes(UITabBarItem.getAttri(), for: .normal)
        tabBarItem.setTitleTextAttributes(UITabBarItem.getSelAttri(), for: .selected)
        tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -8)
        return tabBarItem;
    }


    class func getAttri() -> [NSAttributedString.Key: Any] {
        [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.unTint]
    }

    class func getSelAttri() -> [NSAttributedString.Key: Any] {
        [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.primary]
    }
}
