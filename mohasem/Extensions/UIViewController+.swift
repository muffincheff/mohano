//
//  UIViewController+.swift
//  mohasem
//
//  Created by orca on 2022/09/16.
//

import UIKit

extension UIViewController {
    
    // 현재 화면에 표시된 ViewController
    var sceneViewController: UIViewController {
        // navigation controller가 imbed 되어있으면 마지막 child를 반환한고 그렇지 않으면 자신을 반환한다.
        return self.children.last ?? self
    }
    
    
    func topMostViewController() -> UIViewController? {
        if self.presentedViewController == nil {
            return self
        }
        if let navigation = self.presentedViewController as? UINavigationController {
            return navigation.visibleViewController?.topMostViewController()
        }
        if let tab = self.presentedViewController as? UITabBarController {
            if let selectedTab = tab.selectedViewController {
                return selectedTab.topMostViewController()
            }
            return tab.topMostViewController()
        }
        return self.presentedViewController!.topMostViewController()
    }
}
