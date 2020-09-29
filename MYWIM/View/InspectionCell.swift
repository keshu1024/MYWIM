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
        //data
        topicLabel.text = data.topicName ?? "No Topic Found"
        locationLabel.text = data.location ?? "No Location Added"
        startDateLabel.text = data.startDate ?? ""
        endDateLabel.text = data.endDate ?? ""
        //UI
        checkLabel.textColor = .white
        buttonView.backgroundColor = hexStringToUIColor(hex: data.questionColor ?? "#34C759")
        if data.status == "1" {
            checkLabel.text = "New"
            buttonView.backgroundColor = .systemGreen
        } else {
            checkLabel.text = "Checked"
            buttonView.backgroundColor = hexStringToUIColor(hex: data.questionColor ?? "#34C759")
        }
        
    }
    
    func configureCell(data : ActionData, index : Int) {
        //data
        topicLabel.text = data.topicName ?? "No Topic Found"
        locationLabel.text = data.location ?? "No Location Added"
        startDateLabel.text = data.startDate ?? ""
        endDateLabel.text = data.endDate ?? ""
        //UI
        
        if data.status == "New" {
            buttonView.backgroundColor = .systemIndigo
            checkLabel.text = "New"
        } else {
            buttonView.backgroundColor = .systemGreen
            checkLabel.text = "Checked"
        }
        
        checkLabel.textColor = .white
        
    }
}
