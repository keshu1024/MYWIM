//
//  APIManager.swift
//  Rendezvous
//
//  Created by keshu rai on 30/10/19.
//  Copyright © 2019 com.nvest. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    
    static let sharedObj = APIManager()
    
    private init() {
    }
    
    func getHeader() -> HTTPHeaders? {
        
        return [
            "Content-Type":"application/json",
        ]
        
    }
    
    func requestApi(_ endpoint: String, method: HTTPMethod, param: [String : Any]?, showLoader : Bool, completion: @escaping (_ result:NSDictionary?, _ isSuccess:Bool, _ errorStr:String?) -> Void) {
        if (Reachability()?.isReachable)! {
            
            if showLoader {
                APPDELEGATEOBJ.showIndicator()
                
            }
            var requestUrl = ""
            requestUrl = API.BASE_URL + endpoint
            if method == .get {
                
                AF.request(requestUrl, method: .get, parameters: param, encoding: JSONEncoding.default, headers: getHeader())
                    .responseJSON { response in
                        if showLoader {
                            APPDELEGATEOBJ.hideIndicator()
                        }
                        print(response)
                        if response.response?.statusCode == 200 {
                            if let jsonData = response.value as? NSDictionary {
                                print(jsonData)
                                if jsonData["status"] as? Bool == true || jsonData["status"] as? Int == 1 {
                                    completion(jsonData,true,nil)
                                }else {
                                    completion(nil,false,jsonData["message"] as? String)
                                }
                            }else {
                                completion(nil,false,NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue) as String?)
                            }
                        }else {
                            if let jsonData = response.value as? NSDictionary {
                                if let err = jsonData["message"] as? String {
                                    if err == "Authorization has been denied for this request." {
                                        APPDELEGATEOBJ.makeRootVC(vcName: "LandingVC")
                                    }
                                    completion(nil,false,err)
                                }else {
                                    completion(nil,false,NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue) as String?)
                                }
                            }else {
                                completion(nil,false,"Network Error. Please Try Again Later.")
                            }
                        }
                }
            }else if method == .post {
                
                AF.request(requestUrl, method: .post, parameters: param, encoding: JSONEncoding.default, headers: getHeader())
                    .responseJSON { response in
                        if showLoader {
                            APPDELEGATEOBJ.hideIndicator()
                        }
                        //    print(response)
                        if response.response?.statusCode == 200 {
                            if let jsonData = response.value as? NSDictionary {
                                print(jsonData)
                                if jsonData["status"] as? Bool == true || jsonData["status"] as? Int == 1 {
                                    completion(jsonData,true,nil)
                                }else {
                                    completion(jsonData,false,jsonData["message"] as? String)
                                }
                            }else {
                                completion(nil,false,NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue) as String?)
                            }
                            
                        }else {
                            if let jsonData = response.value as? NSDictionary {
                                if let err = jsonData["message"] as? String {
                                    if err == "Authorization has been denied for this request." {
                                        APPDELEGATEOBJ.makeRootVC(vcName: "LandingVC")
                                    }
                                    completion(nil,false,err)
                                }else {
                                    completion(nil,false,NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue) as String?)
                                }
                            }else {
                                completion(nil,false,"Network Error. Please Try Again Later.")
                            }
                        }
                }
            }
            
        }else {
            completion(nil,false,"No internet connection")
            
             APPDELEGATEOBJ.showAlert("No internet connection")
        }
    }

    func uploadImage(_ endpoint:String, param: [String: String]?, image:UIImage, filename:String, showLoader : Bool, completion: @escaping (_ result:NSDictionary?, _ isSuccess:Bool, _ errorStr:String?) -> Void) {
        if (Reachability()?.isReachable)! {
            if showLoader {
                APPDELEGATEOBJ.showIndicator()
            }
            let requestUrl =  API.BASE_URL + endpoint

            AF.upload(multipartFormData: { multipartFormData in
                guard let imageData = image.jpeg(.lowest) else {
                    print("Image size too large")
                    return
                }
                multipartFormData.append(imageData, withName: filename, fileName: "\(Int(Date().timeIntervalSince1970)).jpeg", mimeType: "image/jpeg")
                if param != nil {
                    for (key,value) in param! {
                        multipartFormData.append((value).data(using: .utf8)!, withName: key)
                    }
                }
            },  to: requestUrl, usingThreshold: UInt64.init(),
                method:.post,
                headers: [
                    "Content-Type":"multipart/form-data",
            ]).response{ response in
                //  print(response)
                APPDELEGATEOBJ.hideIndicator()
                if response.response?.statusCode == 200 {
                    do{
                        if let jsonData = response.data{
                            let parsedData = try JSONSerialization.jsonObject(with: jsonData) as! Dictionary<String, AnyObject>
                            print(parsedData)
                            if parsedData["status"] as? Bool == true || parsedData["status"] as? Int == 1 {
                                completion(parsedData as NSDictionary,true,nil)
                            }else {
                                completion(parsedData as NSDictionary,false,parsedData["message"] as? String)
                            }
                        }
                    }catch{
                        print("error message")
                        completion(nil,false,"Parsing Error.")
                    }
                }else {
                    completion(nil,false,"Network Error")
                }
                APPDELEGATEOBJ.hideIndicator()
            }

        }
        else {
            APPDELEGATEOBJ.showAlert("No internet connection")
        }

    }


    func uploadImages(_ endpoint:String, param: [String: String]?, images:[UIImage], completion: @escaping (_ result:NSDictionary?, _ isSuccess:Bool, _ errorStr:String?) -> Void) {
        
        if (Reachability()?.isReachable)! {
            
            APPDELEGATEOBJ.showIndicator()
            let requestUrl = API.BASE_URL + endpoint
            let encodedURL = requestUrl.replacingOccurrences(of: " ", with: "%20")
            AF.upload(multipartFormData: { multipartFormData in
                for index in 0..<images.count {
                    guard let imageData = images[index].jpeg(.lowest) else {
                        print("Image size too large")
                        return
                    }
                    multipartFormData.append(imageData, withName: "image_\(index+1)", fileName: "\(Int(Date().timeIntervalSince1970))\(index).jpeg", mimeType: "image/jpeg")
                }
                if param != nil {
                    for (key,value) in param! {
                        
                        multipartFormData.append((value).data(using: .utf8)!, withName: key)
                    }
                }
            },to: encodedURL,
              usingThreshold: UInt64.init(),
              method:.post,
              headers: getHeader()).response { response in
                //  print(response)
                APPDELEGATEOBJ.hideIndicator()
                if response.response?.statusCode == 200 {
                    do{
                        if let jsonData = response.data{
                            let parsedData = try JSONSerialization.jsonObject(with: jsonData) as! Dictionary<String, AnyObject>
                            print(parsedData)
                            if parsedData["status"] as? Bool == true || parsedData["status"] as? Int == 1 {
                                completion(parsedData as NSDictionary,true,nil)
                            }else {
                                completion(parsedData as NSDictionary,false,parsedData["message"] as? String)
                            }
                        }
                    }catch{
                        print("error message")
                        completion(nil,false,"Parsing Error.")
                    }
                }else {
                    completion(nil,false,NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue) as String?)
                }
                APPDELEGATEOBJ.hideIndicator()
            }
        }
        else {
            APPDELEGATEOBJ.showAlert("No internet connection")
        }
        
    }
}
