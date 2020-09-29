//
//  ProjectDetailVC.swift
//  MYWIM
//
//  Created by Keshu Rai on 23/09/20.
//  Copyright © 2020 Keshu Rai. All rights reserved.
//

import UIKit

class ProjectDetailVC: UIViewController {
    
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var inspectionTopicLabel : UILabel!
    @IBOutlet weak var locationLabel : UILabel!
    @IBOutlet weak var startDateLabel : UILabel!
    @IBOutlet weak var endDateLabel : UILabel!
    
    @IBOutlet weak var image1View : UIImageView!
    @IBOutlet weak var image2View : UIImageView!
    
    // receive from previous controller
    var inspectionData : InspectionData!
    // end
    
    var questionData : QuestionData? {
        didSet {
            self.tableView.reloadData()
        }
    }
    var imagePicker : ImagePicker!
    var imageSenderFirst = false
    var pickedImage1 : Bool = false
    var pickedImage2 : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        imagePicker = ImagePicker(presentationController: self, delegate: self)
        setupData()
        apiQuestions()
    }

    
    //MARK: Setup Data
    
    func setupData() {
        inspectionTopicLabel.text = inspectionData.topicName ?? ""
        locationLabel.text = inspectionData.location ?? ""
        startDateLabel.text = inspectionData.startDate ?? ""
        endDateLabel.text = inspectionData.endDate ?? ""
        
        if inspectionData.status == "0" {
            image1View.sd_setImage(with: URL(string: API.BASE_IMAGE_URL+( inspectionData.image1 ?? "" )), placeholderImage: UIImage(named: "placeholderImage"), options: .scaleDownLargeImages, context: nil)
            image2View.sd_setImage(with: URL(string: API.BASE_IMAGE_URL+( inspectionData.image2 ?? "" )), placeholderImage: UIImage(named: "placeholderImage"), options: .scaleDownLargeImages, context: nil)
        }
    }
    
    //MARK: Button action
    
    @IBAction func backBtnPressed(_ sender : Any) {
        self.popVC()
    }
    
    @IBAction func image1BtnPressed(_ sender : UIButton) {
        if inspectionData.status == "0" {
            if image1View.image != UIImage(named: "placeholderImage") {
                let imageInfo = GSImageInfo(image: image1View.image!, imageMode: .aspectFit, imageHD: nil)
                let transitionInfo = GSTransitionInfo(fromView: image1View)
                let imageViewer    = GSImageViewerController(imageInfo: imageInfo, transitionInfo: transitionInfo)
                present(imageViewer, animated: true, completion: nil)
            }
        } else {
            imageSenderFirst = true
            imagePicker.present(from: sender)
        }
    }
    
    @IBAction func image2BtnPressed(_ sender : UIButton) {
        if inspectionData.status == "0" {
            if image2View.image != UIImage(named: "placeholderImage") {
                let imageInfo = GSImageInfo(image: image2View.image!, imageMode: .aspectFit, imageHD: nil)
                let transitionInfo = GSTransitionInfo(fromView: image2View)
                let imageViewer    = GSImageViewerController(imageInfo: imageInfo, transitionInfo: transitionInfo)
                present(imageViewer, animated: true, completion: nil)
            }
        } else {
            imageSenderFirst = false
            imagePicker.present(from: sender)
        }
    }
    
    @objc func checkBtnPressed(sender : UIButton) {
        if inspectionData.status == "0" {
            Toast.show(message: "Inspection Already Done.", controller: self)
        } else {
            if pickedImage1 && pickedImage2 {
                showConfirmationAlert(index: sender.tag)
            } else {
                Toast.show(message: "Please attach 2 images first.", controller: self)
            }
        }
    }

    func showConfirmationAlert(index : Int)  {
        let alert = UIAlertController(title: "Confirm", message: "Are you sure you want to submit this rating?", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            self.apiUploadInspectionData(index: index)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: API Call
    
    func apiQuestions() {
        
        let topicId = inspectionData.topicID ?? ""
      
        APIManager.sharedObj.requestApi(API.QUESTIONS + topicId, method: .get, param: nil, showLoader: true) { (response, isSuccess, errorStr) in
              if isSuccess {
                  // save inspections data
                  guard let data = response?["data"] as? Dictionary<String,Any> else { return }
                  do {
                      let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                      let decoder = JSONDecoder()
                      let model = try decoder.decode(QuestionData.self, from: jsonData)
                      self.questionData = model
                  } catch {
                      print(error.localizedDescription)
                  }
              } else {
                Toast.show(message: errorStr ?? "Some Error Occured.", controller: self)
              }
          }
    }
    
    func apiUploadInspectionData(index : Int) {
        
        var question = ""
        let colorHexArray = ["#FF4444","#CC0000","#99CC00","#669900","#FFBB33"]
        switch index {
        case 1:
            question = questionData?.question1 ?? ""
        case 2:
            question = questionData?.question2 ?? ""
        case 3:
            question = questionData?.question3 ?? ""
        case 4:
            question = questionData?.question4 ?? ""
        case 5:
            question = questionData?.question5 ?? ""
        default:
            question = questionData?.question1 ?? ""
            
        }
        
        let params = [
            "id" : inspectionData.inspectionID ?? "",
            "Project" : inspectionData.project ?? "",
            "status" : "ok",
            "end_date" : inspectionData.endDate ?? "",
            "start_date" : inspectionData.startDate ?? "",
            "employee_name" : inspectionData.employeeName ?? "",
            "location" : inspectionData.location ?? "",
            "topic_id" : inspectionData.topicID ?? "",
            "question" : question,
            "question_color": colorHexArray[index-1]
        ]
        
        
        APIManager.sharedObj.uploadImages(API.UPDATE_INSPECTION, param: params, images: [image1View.image!,image2View.image!]) { (response, isSuccess, errorStr) in
            if isSuccess {
                Toast.show(message: "Inspection Updated Successfully.", color: .systemGreen, controller: self)
                DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
                    APPDELEGATEOBJ.makeRootVC(vcName: "DashboardVC")
                }
            } else {
                Toast.show(message: errorStr ?? "Some Error Occured.", controller: self)
            }
        }
    }
}

//MARK: TableView delegate

extension ProjectDetailVC : UITableViewDataSource , UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return questionData != nil ? 5 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : CheckCell = self.tableView.dequeueReusableCell(withIdentifier: "CheckCell", for: indexPath) as! CheckCell
        if questionData != nil {
            let active = (inspectionData.status == "1")
            cell.configureCell(data: questionData!, active : active, index: indexPath.row)
            cell.checkBtn.tag = indexPath.row + 1
            cell.checkBtn.addTarget(self, action: #selector(checkBtnPressed(sender:)), for: .touchUpInside)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//MARK: Image picker delegate

extension ProjectDetailVC : ImagePickerDelegate {
    func didSelect(image: UIImage?, imageName: String?) {
        if let selectedImage = image {
            if imageSenderFirst {
                image1View.image = selectedImage
                pickedImage1 = true
            } else {
                image2View.image = selectedImage
                pickedImage2 = true
            }
        }
    }
    
    
}
