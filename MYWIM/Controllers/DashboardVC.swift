//
//  DashboardVC.swift
//  MYWIM
//
//  Created by Keshu Rai on 23/09/20.
//  Copyright © 2020 Keshu Rai. All rights reserved.
//

import UIKit
import SDWebImage
import Lottie

class DashboardVC: UIViewController {
    
    @IBOutlet weak var segmentBtn : UISegmentedControl!
    @IBOutlet weak var profileImage : UIImageView!
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var lottieAnimationView : AnimationView!
    @IBOutlet weak var emptyView : UIView!
    
    var inspectionData : [InspectionData] = [] {
        didSet {
            emptyView.isHidden = !inspectionData.isEmpty
            self.tableView.reloadData()
        }
    }
    
    var actionData : [ActionData] = [] {
        didSet {
            emptyView.isHidden = !actionData.isEmpty
            self.tableView.reloadData()
        }
    }
    
    var notificationData : [NotificationData] = [] {
        didSet {
            emptyView.isHidden = !notificationData.isEmpty
            self.tableView.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        applyLottieAnimation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        profileImage.layer.cornerRadius = profileImage.frame.size.height / 2
        segmentBtn.addTarget(self, action: #selector(semgmentValueChanged), for: .valueChanged)
        profileImage.sd_setImage(with: URL(string: API.BASE_IMAGE_URL+(DEFAULTS.string(forKey: UserDetails.mPic) ?? "" )), placeholderImage: UIImage(named: "placeholderImage"), options: .scaleDownLargeImages, context: nil)
        emptyView.isHidden = true
        apiInspections()
    }
    
    
    func applyLottieAnimation() {
        
        let animationToShow = Animation.named("noDataAnimation")
        lottieAnimationView.animation = animationToShow
        lottieAnimationView.animationSpeed = 1.0
        lottieAnimationView.loopMode = .loop
        lottieAnimationView.contentMode = .scaleAspectFill
        lottieAnimationView.play()
        
    }
    
    //MARK: Segment changed
    
    @objc func semgmentValueChanged() {
        
        switch segmentBtn.selectedSegmentIndex {
        case 0:
            apiInspections()
        case 1:
            apiActions()
        default:
            apiNotifications()
        }
        self.tableView.reloadData()
    }

    //MARK: Button Actions

    @IBAction func logoutBtnPressed(_ sender : Any) {
        let alert = UIAlertController(title: "Options", message: "Do you want to logout or reset password?", preferredStyle: .alert)
        let yes = UIAlertAction(title: "Logout", style: .default) { (_) in
            self.logout()
        }
        let resetPassword = UIAlertAction(title: "Reset Password", style: .default) { (_) in
            self.pushVC(vcName: "ResetPasswordVC")
        }
        let no = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(yes)
        alert.addAction(resetPassword)
        alert.addAction(no)

        self.present(alert, animated: true, completion: nil)
    }
    
    
    func logout() {
        keychain.clear()
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
        defaults.synchronize()
        APPDELEGATEOBJ.makeRootVC(vcName: "LoginVC")
    }
    
    //MARK: API Call
    
    func apiInspections() {
        APIManager.sharedObj.requestApi(API.INSPECTIONS+(DEFAULTS.string(forKey: UserDetails.masterUserID) ?? ""), method: .get, param: nil, showLoader: true) { (response, isSuccess, errorStr) in
            if isSuccess {
                // save inspections data
                guard let data = response?["data"] as? [Dictionary<String,Any>] else { return }
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    let decoder = JSONDecoder()
                    let model = try decoder.decode([InspectionData].self, from: jsonData)
                    self.inspectionData = model
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                self.emptyView.isHidden = false
            }
        }
    }
    
    func apiActions() {
        APIManager.sharedObj.requestApi(API.ACTIONS+(DEFAULTS.string(forKey: UserDetails.masterUserID) ?? ""), method: .get, param: nil, showLoader: true) { (response, isSuccess, errorStr) in
            if isSuccess {
                // save inspections data
                guard let data = response?["data"] as? [Dictionary<String,Any>] else { return }
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    let decoder = JSONDecoder()
                    let model = try decoder.decode([ActionData].self, from: jsonData)
                    self.actionData = model
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                self.emptyView.isHidden = false
            }
        }
    }
    
    func apiNotifications() {
        APIManager.sharedObj.requestApi(API.NOTIFICATIONS, method: .get, param: nil, showLoader: true) { (response, isSuccess, errorStr) in
                if isSuccess {
                    // save inspections data
                    guard let data = response?["data"] as? [Dictionary<String,Any>] else { return }
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                        let decoder = JSONDecoder()
                        let model = try decoder.decode([NotificationData].self, from: jsonData)
                        self.notificationData = model
                    } catch {
                        print(error.localizedDescription)
                    }
                } else {
                    self.emptyView.isHidden = false
                }
            }
    }
    
    
    
}

//MARK: TableView

extension DashboardVC : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch segmentBtn.selectedSegmentIndex {
        case 0:
            let cell : InspectionCell  = self.tableView.dequeueReusableCell(withIdentifier: "InspectionCell", for: indexPath) as! InspectionCell
            cell.configureCell(data: inspectionData[indexPath.row], index: indexPath.row)
            return cell
        case 1:
            let cell : InspectionCell  = self.tableView.dequeueReusableCell(withIdentifier: "InspectionCell", for: indexPath) as! InspectionCell
            cell.configureCell(data: actionData[indexPath.row], index: indexPath.row)
            return cell
        case 2:
            let cell : NotificationCell  = self.tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
            cell.configureCell(data: notificationData[indexPath.row], index: indexPath.row)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentBtn.selectedSegmentIndex {
        case 0:
            return inspectionData.count
        case 1:
            return actionData.count
        default:
            return notificationData.count
        }
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
        if segmentBtn.selectedSegmentIndex == 0 {
            let vc = mainStoryBoard.instantiateViewController(withIdentifier: "ProjectDetailVC") as! ProjectDetailVC
            vc.inspectionData = self.inspectionData[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if segmentBtn.selectedSegmentIndex == 1 {
            let vc = mainStoryBoard.instantiateViewController(withIdentifier: "ActionDetailVC") as! ActionDetailVC
            vc.actionData = self.actionData[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}


