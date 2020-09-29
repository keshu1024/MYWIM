//
//  ActionDetailVC.swift
//  MYWIM
//
//  Created by Keshu Rai on 30/09/20.
//  Copyright © 2020 Keshu Rai. All rights reserved.
//

import UIKit

class ActionDetailVC: UIViewController {
    
    @IBOutlet weak var inspectionTopicLabel : UILabel!
    @IBOutlet weak var locationLabel : UILabel!
    @IBOutlet weak var startDateLabel : UILabel!
    @IBOutlet weak var endDateLabel : UILabel!
    @IBOutlet weak var actionTextView : UITextView!
    @IBOutlet weak var image1View : UIImageView!
    @IBOutlet weak var addImageBtn : UIButton!
    @IBOutlet weak var doneBtn : UIButton!
    
    
    var imagePicker : ImagePicker!
    var pickedImage : Bool = false
    var actionData : ActionData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = ImagePicker(presentationController: self, delegate: self)
        setupData()
        doneBtn.layer.borderColor = UIColor.systemIndigo.cgColor
        doneBtn.layer.borderWidth = 0.9
    }
    func setupData() {
        inspectionTopicLabel.text = actionData.topicName ?? ""
        locationLabel.text = actionData.location ?? ""
        startDateLabel.text = actionData.startDate ?? ""
        endDateLabel.text = actionData.endDate ?? ""
        
        if actionData.status == "ok" {
            actionTextView.text = actionData.action ?? ""
            image1View.sd_setImage(with: URL(string: API.BASE_IMAGE_URL+( actionData.image ?? "" )), placeholderImage: UIImage(named: "placeholderImage"), options: .scaleDownLargeImages, context: nil)
            actionTextView.isUserInteractionEnabled = false
        } else {
            actionTextView.isUserInteractionEnabled = true
        }

    }
    
    func areValidFields() -> Bool {
        var message = ""
        if !pickedImage {
            message = "Please Select An Image First."
        }
        else if actionTextView.text!.trim() == "" {
            message = "Please Provide Some Detail In Action Field."
        } else {
            return true
        }
        Toast.show(message: message, controller: self)
        return false
    }
    
    @IBAction func backBtnPressed(_ sender : Any) {
        self.popVC()
    }
    
    @IBAction func doneBtnPressed(_ sender : Any) {
        if actionData.status == "New" {
            if areValidFields() {
                apiSubmitAction()
            }
        } else {
            Toast.show(message: "Action Has Already Been Updated.", controller: self)
        }
    }
    
    @IBAction func image1BtnPressed(_ sender : UIButton) {
        if actionData.status == "ok" {
            if image1View.image != UIImage(named: "placeholderImage") {
                let imageInfo = GSImageInfo(image: image1View.image!, imageMode: .aspectFit, imageHD: nil)
                let transitionInfo = GSTransitionInfo(fromView: image1View)
                let imageViewer    = GSImageViewerController(imageInfo: imageInfo, transitionInfo: transitionInfo)
                present(imageViewer, animated: true, completion: nil)
            }
        } else {
            imagePicker.present(from: sender)
        }
    }
    
    func apiSubmitAction() {
        let params = [
            "id" : actionData.actionID ?? "",
            "topic_name" : actionData.topicName ?? "",
            "status" : "ok",
            "end_date" : actionData.endDate ?? "",
            "start_date" : actionData.startDate ?? "",
            "employee_name" : actionData.employeeName ?? "",
            "location" : actionData.location ?? "",
            "topic" : actionData.topicID ?? "",
            "action" : self.actionTextView.text!
        ]
        
        APIManager.sharedObj.uploadImage(API.UPDATE_ACTION, param: params, image: image1View.image!, filename: "image", showLoader: true) { (response, isSuccess, errorStr) in
            if isSuccess {
                Toast.show(message: "Action Updated Successfully.", color: .systemGreen, controller: self)
                DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
                    APPDELEGATEOBJ.makeRootVC(vcName: "DashboardVC")
                }
            } else {
                Toast.show(message: errorStr ?? "Some Error Occured. Try Again Later.", controller: self)
            }
        }
    }
    
}

extension ActionDetailVC : ImagePickerDelegate {
    func didSelect(image: UIImage?, imageName: String?) {
        if let selectedImage = image {
            image1View.image = selectedImage
            pickedImage = true
        }
    }
    
    
}
