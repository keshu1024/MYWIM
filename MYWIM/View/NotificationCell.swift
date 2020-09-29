//
//  NotificationCell.swift
//  MYWIM
//
//  Created by Keshu Rai on 29/09/20.
//  Copyright © 2020 Keshu Rai. All rights reserved.
//

import Foundation
import UIKit

class NotificationCell : UITableViewCell {
    
    @IBOutlet weak var mainView : UIView!
    @IBOutlet weak var notificationTitle : UILabel!
    @IBOutlet weak var notificationDate : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.addBorder()
    }
    
    func configureCell(data : NotificationData, index : Int) {
        notificationTitle.text = data.notification ?? ""
        notificationDate.text = data.sentDate ?? ""
    }
}

