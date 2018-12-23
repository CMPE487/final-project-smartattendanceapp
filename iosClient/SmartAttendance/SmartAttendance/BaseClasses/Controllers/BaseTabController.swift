//
//  BaseUITabController.swift
//  AS-BaseProject
//
//  Created by Korhan Çağın Geboloğlu on 13.09.2018.
//  Copyright © 2018 Korhan Çağın Geboloğlu. All rights reserved.
//

import UIKit

struct TabBarVCModel {
    var imageName: String?
    var title: String?
    var VCToShow: UIViewController?
}

/**
 
 **Usage:** Here is the one way to use this class.
 
 if let window = window {
 
  &nbsp;&nbsp;&nbsp;let mainVC = BaseTabController()
 
  &nbsp;&nbsp;&nbsp;mainVC.tabBar.barTintColor = UIColor.red

  &nbsp;&nbsp;&nbsp;mainVC.tabBar.tintColor = UIColor.yellow
 
  &nbsp;&nbsp;&nbsp;mainVC.tabBarInfo = [TabBarVCModel(imageName: "cpc", title: "1", VCToShow: BaseController()),...]
 
  &nbsp;&nbsp;&nbsp;window.rootViewController = mainVC
 
 }
 
  **Note:** This example is implemented in AppDelegate. However, this class can be used easily by looking at this example. Another key feature of this implementation is the tagging system. Each View Controller has a tag value of their index in the tabBarInfo array. Hence, the first element gets the tag of 0.
 */

class BaseTabController: UITabBarController {
    public var tabBarInfo = [TabBarVCModel]() { didSet { setupTabBar() } }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTabBar() {
        for item in tabBarInfo {
            if item.imageName == nil || item.title == nil || item.VCToShow == nil {
                print("Set all values in the TabBarVCModel")
                return
            }
        }

        for index in 0..<tabBarInfo.count {
            let currentTabBarItem = tabBarInfo[index]

            let pageName = NSLocalizedString(currentTabBarItem.title ?? "", comment: "")
            let pageImage = UIImage(named: currentTabBarItem.imageName ?? "")?.withRenderingMode(.alwaysTemplate)

            let VCTabBarItem = UITabBarItem(title: pageName, image: pageImage, tag: index)
            tabBarInfo[index].VCToShow?.tabBarItem = VCTabBarItem
        }

        viewControllers = tabBarInfo.map { UINavigationController(rootViewController: $0.VCToShow!) }
    }

}
