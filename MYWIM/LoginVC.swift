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


    @IBAction func resetBtnPressed( _ sender: Any) {
        self.pushVC(vcName: "ResetPasswordVC")
    }
    
    @IBAction func signinBtnPressed(_ sender : Any) {
        APPDELEGATEOBJ.makeRootVC(vcName: "DashboardVC")
    }
}

