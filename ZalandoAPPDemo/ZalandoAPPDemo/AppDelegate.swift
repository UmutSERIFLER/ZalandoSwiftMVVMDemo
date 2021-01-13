//
//  AppDelegate.swift
//  ZalandoAPPDemo
//
//  Created by Umut SERIFLER on 13/01/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let tabbarVC = TabbarViewController.init(nibName: TabbarViewController.identifier, bundle: nil)
        window!.makeKeyAndVisible()
        window!.rootViewController = tabbarVC
        return true
    }


}

