//
//  QuestionData.swift
//  MYWIM
//
//  Created by Keshu Rai on 29/09/20.
//  Copyright © 2020 Keshu Rai. All rights reserved.
//

import UIKit

// MARK: - QuestionData
struct QuestionData: Codable {
    var topicID, topicName, question1, question2: String?
    var question3, question4, question5, isDelete: String?

    enum CodingKeys: String, CodingKey {
        case topicID = "topic_id"
        case topicName = "topic_name"
        case question1, question2, question3, question4, question5
        case isDelete = "is_delete"
    }
}
