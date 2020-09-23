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

    override func viewDidLoad() {
        super.viewDidLoad()
        resetBtn.layer.cornerRadius = 10

    }
    
    
    @IBAction func backBtnPressed(_ sender : Any) {
        self.popVC()
    }


}
