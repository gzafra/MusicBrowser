//
//  AppDelegate.swift
//  MusicBrowser
//
//  Created by Guillermo Zafra on 16/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        presentInitialViewController()
        
        return true
    }
    
    func presentInitialViewController() {
        let navigationController = UINavigationController()
        guard let initialVC = BrowseSongsRouter.setupModule(with: navigationController) as? UIViewController else {
            assertionFailure("Could not load initial ViewController")
            return
        }
        window = UIWindow(frame: UIScreen.main.bounds)
        navigationController.viewControllers = [initialVC]
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }


}

