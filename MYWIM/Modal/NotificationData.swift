//
//  NotificationData.swift
//  MYWIM
//
//  Created by Keshu Rai on 29/09/20.
//  Copyright © 2020 Keshu Rai. All rights reserved.
//

import Foundation


// MARK: - Datum
struct NotificationData: Codable {
    var notificationID, notification, sentDate: String?

    enum CodingKeys: String, CodingKey {
        case notificationID = "notification_id"
        case notification
        case sentDate = "sent_date"
    }
}

