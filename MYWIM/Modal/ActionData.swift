//
//  ActionData.swift
//  MYWIM
//
//  Created by Keshu Rai on 29/09/20.
//  Copyright © 2020 Keshu Rai. All rights reserved.
//

import Foundation

struct ActionData: Codable {
    var actionID, action, employeeName, startDate: String?
    var endDate, topic, status, location: String?
    var image: String?
    var isDelete, topicName, topicID, name: String?
    
    enum CodingKeys: String, CodingKey {
        case actionID = "action_id"
        case action
        case employeeName = "employee_name"
        case startDate = "start_date"
        case endDate = "end_date"
        case topic, status, location, image
        case isDelete = "is_delete"
        case topicName = "topic_name"
        case topicID = "topic_id"
        case name
    }
}
