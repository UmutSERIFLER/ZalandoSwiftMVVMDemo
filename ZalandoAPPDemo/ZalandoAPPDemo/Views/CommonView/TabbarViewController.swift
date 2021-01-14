//
//  TabbarViewController.swift
//  ZalandoAPPDemo
//
//  Created by Umut SERIFLER on 13/01/2021.
//

import UIKit

enum TabBarItems: String {
    case CategoryCV
    case Favourite
    case CategoryTV
}

class TabbarViewController: UITabBarController, UITabBarControllerDelegate {
    
    var viewControllersArray: [UIViewController]!
    var itemController: TabbarItemController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.tabBar.tintColor = .orange
        viewControllersArray = []
        viewControllersArray?.append(setViewControllerForTabBarItem(itemType: .CategoryCV))
        viewControllersArray?.append(setViewControllerForTabBarItem(itemType: .Favourite))
        viewControllersArray?.append(setViewControllerForTabBarItem(itemType: .CategoryTV))
        viewControllers = viewControllersArray
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
    
}

private extension TabbarViewController{
    
    func setViewControllerForTabBarItem(itemType: TabBarItems)-> UIViewController {
        itemController =  TabbarItemController(itemType: itemType)
        itemController.controller.tabBarItem = UITabBarItem(title: itemType.rawValue, image: UIImage(named: itemController.imageDisabled)!.withRenderingMode(.automatic), selectedImage: UIImage(named:itemController.imageEnabled)?.withRenderingMode(.automatic))
        let viewController = UINavigationController(rootViewController: itemController.controller)
        return viewController
    }
}


