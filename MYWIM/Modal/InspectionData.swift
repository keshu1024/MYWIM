//
//  InspectionData.swift
//  MYWIM
//
//  Created by Keshu Rai on 29/09/20.
//  Copyright © 2020 Keshu Rai. All rights reserved.
//

import Foundation

// MARK: - InspectionData
struct InspectionData: Codable {
    var inspectionID, location, employeeName, startDate: String?
    var endDate, status, project, topicName: String?
    var question, questionColor, image1, image2: String?
    var isDelete, topicID, name: String?

    enum CodingKeys: String, CodingKey {
        case inspectionID = "inspection_id"
        case location
        case employeeName = "employee_name"
        case startDate = "start_date"
        case endDate = "end_date"
        case status
        case project = "Project"
        case topicName = "topic_name"
        case question
        case questionColor = "question_color"
        case image1 = "image_1"
        case image2 = "image_2"
        case isDelete = "is_delete"
        case topicID = "topic_id"
        case name
    }
}
