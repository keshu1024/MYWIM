//
//  InspectionCell.swift
//  MYWIM
//
//  Created by Keshu Rai on 29/09/20.
//  Copyright © 2020 Keshu Rai. All rights reserved.
//

import Foundation
import UIKit

class InspectionCell : UITableViewCell {
    
    @IBOutlet weak var mainView : UIView!
    @IBOutlet weak var buttonView : UIView!
    @IBOutlet weak var checkLabel : UILabel!
    @IBOutlet weak var topicLabel : UILabel!
    @IBOutlet weak var locationLabel : UILabel!
    @IBOutlet weak var startDateLabel : UILabel!
    @IBOutlet weak var endDateLabel : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.addBorder()
    }
    
    func configureCell(data : InspectionData, index : Int) {
        topicLabel.text = data.topicName ?? "No Topic Found"
        locationLabel.text = data.location ?? "No Location Added"
        startDateLabel.text = data.startDate ?? ""
        endDateLabel.text = data.endDate ?? ""
    }
    
    func configureCell(data : ActionData, index : Int) {
        topicLabel.text = data.topicName ?? "No Topic Found"
        locationLabel.text = data.location ?? "No Location Added"
        startDateLabel.text = data.startDate ?? ""
        endDateLabel.text = data.endDate ?? ""
    }
}
