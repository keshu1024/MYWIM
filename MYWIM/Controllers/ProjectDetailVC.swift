//
//  ProjectDetailVC.swift
//  MYWIM
//
//  Created by Keshu Rai on 23/09/20.
//  Copyright © 2020 Keshu Rai. All rights reserved.
//

import UIKit

class CheckCell : UITableViewCell {
    
    @IBOutlet weak var mainView : UIView!
    @IBOutlet weak var checkBtn : UIButton!
    @IBOutlet weak var colorView : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.addBorder()
        checkBtn.layer.borderWidth = 0.7
        checkBtn.layer.borderColor = UIColor.systemIndigo.cgColor
        colorView.layer.cornerRadius = 5
    }
    
}


class ProjectDetailVC: UIViewController {
    
    @IBOutlet weak var tableView : UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }

    
    @IBAction func backBtnPressed(_ sender : Any) {
        self.popVC()
    }
}

extension ProjectDetailVC : UITableViewDataSource , UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : CheckCell = self.tableView.dequeueReusableCell(withIdentifier: "CheckCell", for: indexPath) as! CheckCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
