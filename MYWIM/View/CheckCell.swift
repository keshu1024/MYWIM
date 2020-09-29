//
//  CheckCell.swift
//  MYWIM
//
//  Created by Keshu Rai on 29/09/20.
//  Copyright © 2020 Keshu Rai. All rights reserved.
//

import Foundation
import UIKit

class CheckCell : UITableViewCell {
    
    @IBOutlet weak var mainView : UIView!
    @IBOutlet weak var checkBtn : UIButton!
    @IBOutlet weak var colorView : UIView!
    @IBOutlet weak var questionLabel : UILabel!
    @IBOutlet weak var countLabel : UILabel!
    
    var colorHexArray : [String] = ["FF4444","CC0000","99CC00","669900","FFBB33"]

    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.addBorder()
    }
    
    func configureCell(data : QuestionData, active : Bool, index : Int) {
        colorView.backgroundColor = hexStringToUIColor(hex: colorHexArray[index])
        countLabel.text = "\(index+1)"
        switch index {
        case 0:
            questionLabel.text = data.question1
        case 1:
            questionLabel.text = data.question2
        case 2:
            questionLabel.text = data.question3
        case 3:
            questionLabel.text = data.question4
        case 4:
            questionLabel.text = data.question5
        default:
            questionLabel.text = data.question1
            
        }
        
        // if active inspection
        
        if active {
            checkBtn.layer.borderWidth = 0.7
            checkBtn.layer.borderColor = UIColor.systemIndigo.cgColor
            checkBtn.setTitleColor(.systemIndigo, for: .normal)
            colorView.layer.cornerRadius = 5
        } else {
            checkBtn.layer.borderWidth = 0.7
            checkBtn.layer.borderColor = UIColor.secondaryLabel.cgColor
            checkBtn.setTitleColor(.secondaryLabel, for: .normal)
            colorView.layer.cornerRadius = 5
        }
    }

}


