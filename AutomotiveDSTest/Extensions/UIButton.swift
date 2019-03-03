//
//  UIButton.swift
//  AutomotiveDSTest
//
//  Created by Juan Armario Munoz on 2019-03-03.
//  Copyright © 2019 Juan Armario Munoz. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    /// Method to post a notification when the button is pressed
    ///
    /// - Parameter notificationName: name of the notification to post
    func postNotificationWithName(notificationName: String) {
        let name = Notification.Name(rawValue: notificationName)
        NotificationCenter.default.post(name: name, object: nil)
    }
}
