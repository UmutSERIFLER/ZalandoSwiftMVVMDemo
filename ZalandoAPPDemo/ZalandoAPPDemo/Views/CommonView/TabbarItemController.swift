//
//  TabbarItemController.swift
//  ZalandoAPPDemo
//
//  Created by Umut SERIFLER on 13/01/2021.
//

import UIKit

struct TabbarItemController {
    
    let controller: UIViewController
    let imageEnabled: String
    let imageDisabled: String
    private let controllerName: String

    init(itemType: TabBarItems) {
        switch itemType {
        case .Category:
            self.controllerName = CategoryViewController.identifier
            self.controller = CategoryViewController()
            self.imageEnabled = "category_active_icon"
            self.imageDisabled = "category_inactive_icon"
        case .Favourite:
            self.controllerName = FavouriteViewController.identifier
            self.controller = FavouriteViewController()
            self.imageEnabled = "favourite_active_icon"
            self.imageDisabled = "favourite_inactive_icon"
        }
    }
}
