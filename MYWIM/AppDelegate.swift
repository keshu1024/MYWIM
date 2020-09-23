//
//  AppDelegate.swift
//  MYWIM
//
//  Created by Keshu Rai on 18/09/20.
//  Copyright © 2020 Keshu Rai. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    
    func makeRootVC(vcName : String) {
        let vc = mainStoryBoard.instantiateViewController(withIdentifier: vcName)
        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.isHidden = true
        self.window?.rootViewController = nav
        let options: UIView.AnimationOptions = .transitionCrossDissolve
        let duration: TimeInterval = 0.6
        UIView.transition(with: self.window!, duration: duration, options: options, animations: {}, completion: nil)
    }
    

}


