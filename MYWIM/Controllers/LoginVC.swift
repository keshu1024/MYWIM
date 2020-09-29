//
//  ViewController.swift
//  MYWIM
//
//  Created by Keshu Rai on 18/09/20.
//  Copyright © 2020 Keshu Rai. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var usernameField : UITextField!
    @IBOutlet weak var passwordField : UITextField!
    @IBOutlet weak var loginBtn : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordField.isSecureTextEntry = true
        loginBtn.layer.cornerRadius = 10
    }

    //MARK: Field Validation
    
    func areValidFields() -> Bool {
        var message = ""
        if usernameField.text!.count == 0 {
            message = "Please Enter The Username."
        }
        else if passwordField.text!.count == 0 {
            message = "Please Enter Password."
        }
        else {
            return true
        }
        Toast.show(message: message, controller: self)
        return false
    }

    //MARK: Button actions
    
    @IBAction func resetBtnPressed( _ sender: Any) {
        self.pushVC(vcName: "ResetPasswordVC")
    }
    
    @IBAction func signinBtnPressed(_ sender : Any) {
        if areValidFields() {
            apiLogin()
        }
    }
    
    //MARK: Login api call
    
    func apiLogin() {
        let params = [
            "user_token" : UUID().uuidString ,
            "m_user_name" : usernameField.text!,
            "m_password": passwordField.text!
        ]
        
        APIManager.sharedObj.requestApi(API.LOGIN, method: .post, param: params, showLoader: true) { (response, isSuccess, errorStr) in
            if isSuccess {
                // save user data and then move to next screen
                APPDELEGATEOBJ.makeRootVC(vcName: "DashboardVC")
            } else {
                Toast.show(message: errorStr ?? "Some Error Occured.", controller: self)
            }
        }
    }
}

