//
//  UserResponseData.swift
//  MYWIM
//
//  Created by Keshu Rai on 24/09/20.
//  Copyright © 2020 Keshu Rai. All rights reserved.
//

import Foundation


struct UserResponseData: Codable {
    var masterUserID, mFirstName, mLastName, email: String?
    var mUserName, mPassword, mPic, userToken: String?
    var isDelete, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case masterUserID = "master_user_id"
        case mFirstName = "m_first_name"
        case mLastName = "m_last_name"
        case email
        case mUserName = "m_user_name"
        case mPassword = "m_password"
        case mPic = "m_pic"
        case userToken = "user_token"
        case isDelete = "is_delete"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}


struct UserDetails {
    
    static let masterUserID = "_id"
    static let mFirstName = "user_id"
    static let mLastName = "userType"
    static let email = "email"
    static let mUserName = "mobile"
    static let mPassword = "username"
    static let mPic = "date_of_birth"
    static let userToken = "mobile_verification_status"
    static let isDelete = "email_verification_status"
    static let createdAt = "tfa_enabled_for"
    static let updatedAt = "istwofaenabled"

    static func setUserDetails(userRecords : UserResponseData) {
        DEFAULTS.set(userRecords.masterUserID, forKey: UserDetails.masterUserID)
        DEFAULTS.set(userRecords.mFirstName, forKey: UserDetails.mFirstName)
        DEFAULTS.set(userRecords.mLastName, forKey: UserDetails.mLastName)
        DEFAULTS.set(userRecords.mUserName, forKey: UserDetails.mUserName)
        DEFAULTS.set(userRecords.mPassword, forKey: UserDetails.mPassword)
        DEFAULTS.set(userRecords.email, forKey: UserDetails.email)
        DEFAULTS.set(userRecords.mPic, forKey: UserDetails.mPic)
        DEFAULTS.set(userRecords.userToken, forKey: UserDetails.userToken)
        DEFAULTS.set(userRecords.isDelete, forKey: UserDetails.isDelete)
        DEFAULTS.set(userRecords.createdAt, forKey: UserDetails.createdAt)
        DEFAULTS.set(userRecords.updatedAt, forKey: UserDetails.updatedAt)
        DEFAULTS.synchronize()
    }
}
