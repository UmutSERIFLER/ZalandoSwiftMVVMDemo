//
//  TabbarViewController.swift
//  ZalandoAPPDemo
//
//  Created by Umut SERIFLER on 13/01/2021.
//

import UIKit

enum TabBarItems: String {
    case Category
    case Favourite
}

class TabbarViewController: UITabBarController, UITabBarControllerDelegate {
    
    var viewControllersArray: [UIViewController]!
    var itemController: TabbarItemController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.tabBar.tintColor = UIColor(red: 255/255, green: 126/255, blue: 0/255, alpha: 1.0)
        viewControllersArray = []
        viewControllersArray?.append(setViewControllerForTabBarItem(itemType: .Category))
        viewControllersArray?.append(setViewControllerForTabBarItem(itemType: .Favourite))
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


