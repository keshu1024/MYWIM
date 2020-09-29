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
