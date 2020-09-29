//
//  DashboardVC.swift
//  MYWIM
//
//  Created by Keshu Rai on 23/09/20.
//  Copyright © 2020 Keshu Rai. All rights reserved.
//

import UIKit


class InspectionCell : UITableViewCell {
    
    @IBOutlet weak var mainView : UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

class NotificationCell : UITableViewCell {
    
    @IBOutlet weak var mainView : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}



class DashboardVC: UIViewController {
    
    @IBOutlet weak var segmentBtn : UISegmentedControl!
    @IBOutlet weak var profileImage : UIImageView!
    @IBOutlet weak var tableView : UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        profileImage.layer.cornerRadius = profileImage.frame.size.height / 2
        segmentBtn.addTarget(self, action: #selector(semgmentValueChanged), for: .valueChanged)
    }
    
    @objc func semgmentValueChanged() {
        self.tableView.reloadData()
    }
    
    //MARK: IBAction

    @IBAction func logoutBtnPressed(_ sender : Any) {
        let alert = UIAlertController(title: "Logout?", message: "Are you sure you want to logout?", preferredStyle: .alert)
        let yes = UIAlertAction(title: "Yes", style: .default) { (_) in
            APPDELEGATEOBJ.makeRootVC(vcName: "LoginVC")
        }
        let no = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alert.addAction(yes)
        alert.addAction(no)
        self.present(alert, animated: true, completion: nil)
    }
    
}


extension DashboardVC : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch segmentBtn.selectedSegmentIndex {
        case 0,1:
            let cell : InspectionCell  = self.tableView.dequeueReusableCell(withIdentifier: "InspectionCell", for: indexPath) as! InspectionCell
            cell.mainView.addBorder()
            return cell
        case 2:
            let cell : NotificationCell  = self.tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
            cell.mainView.addBorder()
            return cell
        default:
            let cell : InspectionCell  = self.tableView.dequeueReusableCell(withIdentifier: "InspectionCell", for: indexPath) as! InspectionCell
            cell.mainView.addBorder()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch segmentBtn.selectedSegmentIndex {
        case 0,1:
            return 160
        default:
            return 80
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if segmentBtn.selectedSegmentIndex == 0 || segmentBtn.selectedSegmentIndex == 1 {
            self.pushVC(vcName: "ProjectDetailVC")
        }
    }
    
}


