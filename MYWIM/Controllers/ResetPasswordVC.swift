//
//  ResetPasswordVC.swift
//  MYWIM
//
//  Created by Keshu Rai on 23/09/20.
//  Copyright © 2020 Keshu Rai. All rights reserved.
//

import UIKit

class ResetPasswordVC: UIViewController {
    
    @IBOutlet weak var resetBtn : UIButton!
    @IBOutlet weak var passwordField : UITextField!
    @IBOutlet weak var confirmPasswordField : UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        resetBtn.layer.cornerRadius = 10

    }
    
    //MARK: Field Validation
    
    func areValidFields() -> Bool {
        var message = ""
        if passwordField.text!.trim() == "" {
            message = "Please Enter A Password."
        }
        else if confirmPasswordField.text!.trim() == "" {
            message = "Please Enter The Password Again To Confirm"
        }
        else if passwordField.text!.trim() == confirmPasswordField.text!.trim() {
            message = "Password Do Not Match. Please Enter Again."
        }
        else {
            return true
        }
        Toast.show(message: message, controller: self)
        return false
    }
    
    //MARK: Button Actions
    
    @IBAction func backBtnPressed(_ sender : Any) {
        self.popVC()
    }
    
    @IBAction func resetBtnPressed(_ sender : Any) {
        if areValidFields() {
            apiResetPassword()
        }
    }
    
    //MARK: Api call for reset password
    
    func apiResetPassword() {
        let params = [
            "id" : "master_user_id",
            "m_password" : passwordField.text!.trim()
        ]
        APIManager.sharedObj.requestApi(API.RESET_PASSWORD, method: .post, param: params, showLoader: true) { (response, isSuccess, errorStr) in
            if isSuccess {
                
            } else {
                Toast.show(message: errorStr ?? "Some Error Occured." , controller: self)
            }
        }
    }


}
