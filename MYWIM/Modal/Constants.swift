//
//  Constants.swift
//  MYWIM
//
//  Created by Keshu Rai on 24/09/20.
//  Copyright © 2020 Keshu Rai. All rights reserved.
//

import Foundation
import UIKit
import KeychainSwift

let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
let APPDELEGATEOBJ = UIApplication.shared.delegate as! AppDelegate
let DEFAULTS = UserDefaults.standard
let keychain = KeychainSwift()


struct API {
  
    static let BASE_URL = "https://demo.mywim.nl/Api/"
    static let BASE_IMAGE_URL = "https://demo.mywim.nl/uploads/"
    
    //POST - Login and Reset Screen
    static let LOGIN = "login"
    static let RESET_PASSWORD = "reset_password"
    
    //GET - dashboard screen
    static let INSPECTIONS = "employee_inspections/" ///+ud.master_user_id
    static let ACTIONS = "employee_actions/" ///+ud.master_user_id;
    static let NOTIFICATIONS = "notification" ///get
}
