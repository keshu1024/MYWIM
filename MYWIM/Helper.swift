//
//  Constants.swift
//  MYWIM
//
//  Created by Keshu Rai on 23/09/20.
//  Copyright © 2020 Keshu Rai. All rights reserved.
//

import Foundation
import UIKit

let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
let APPDELEGATEOBJ = UIApplication.shared.delegate as! AppDelegate


extension UIViewController {
    func pushVC(vcName : String) {
        let vc = mainStoryBoard.instantiateViewController(withIdentifier: vcName)
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
     func popVC() {
         self.navigationController?.popViewController(animated: true)
     }
}

extension UIView {
    func addBorder()  {
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.5
    }
}
