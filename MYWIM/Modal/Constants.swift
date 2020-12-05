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
var DEVICE_TOKEN = ""


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
    static let QUESTIONS = "topic/"
    static let UPDATE_INSPECTION = "update_inspection"
    static let UPDATE_ACTION = "update_action"
}


//MARK:- global function

internal func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
