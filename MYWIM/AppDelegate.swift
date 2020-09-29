//
//  AppDelegate.swift
//  MYWIM
//
//  Created by Keshu Rai on 18/09/20.
//  Copyright © 2020 Keshu Rai. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        checkSession()
        return true
    }
    
    func checkSession() {
        if DEFAULTS.string(forKey: UserDetails.masterUserID) == nil || DEFAULTS.string(forKey: UserDetails.masterUserID) == "" {
            APPDELEGATEOBJ.makeRootVC(vcName: "LoginVC")
        } else {
            APPDELEGATEOBJ.makeRootVC(vcName: "DashboardVC")
        }
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
    
      
      func showAlert(_ str : String) {
          let alert = UIAlertController(title: "Error!", message: str, preferredStyle: .alert)
          let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
          alert.addAction(alertAction)
          self.window?.rootViewController?.present(alert, animated: true, completion: nil)
      }
      
      func showAlertWithTitle(title : String, _ str : String) {
          let alert = UIAlertController(title: title, message: str, preferredStyle: .alert)
          let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
          alert.addAction(alertAction)
          self.window?.rootViewController?.present(alert, animated: true, completion: nil)
      }
      
      func showIndicator() {
          IndicatorView.shared.show(controller: UIApplication.shared.keyWindow!.rootViewController!)
      }
      
      
      func hideIndicator() {
          IndicatorView.shared.hide()
      }
    
}


