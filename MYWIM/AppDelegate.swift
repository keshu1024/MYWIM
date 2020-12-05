//
//  AppDelegate.swift
//  MYWIM
//
//  Created by Keshu Rai on 18/09/20.
//  Copyright © 2020 Keshu Rai. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import UserNotifications
import Firebase


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        checkSession()
        
        //request push notification permission
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            guard granted else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
        UNUserNotificationCenter.current().delegate = self;
        //firebase
        FirebaseApp.configure()
        Messaging.messaging().delegate = self

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
    
    //push notifications
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // 1. Convert device token to string
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        let token = tokenParts.joined()
        // 2. Print device token to use for PNs payloads
        print("Device Token: \(token)")
        let bundleID = Bundle.main.bundleIdentifier;
        print("Bundle ID: \(token) \(bundleID)");
        // 3. Save the token to local storeage and post to app server to generate Push Notification. ...
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("failed to register for remote notifications: \(error.localizedDescription)")
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        print("Received push notification: \(userInfo)")
        let aps = userInfo["aps"] as! [String: Any]
        print("\(aps)")
    }
    
    
}


extension AppDelegate : UNUserNotificationCenterDelegate, MessagingDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print(notification.request.content.body);
        completionHandler([.alert, .sound])
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
      print("Firebase registration token: \(String(describing: fcmToken))")
        DEVICE_TOKEN = fcmToken
        let dataDict:[String: String] = ["token": fcmToken ]
      NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
      // TODO: If necessary send token to application server.
      // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
}


