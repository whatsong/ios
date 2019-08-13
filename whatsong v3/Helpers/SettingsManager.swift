//
//  SettingsManager.swift
//  whatsong v3
//
//  Created by Andrii Shchudlo on 19/06/2019.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

extension Notification.Name {
    public static let wsNotificationLikeSong = Notification.Name(rawValue: "com.whatsong.likeSong")
    public static let wsNotificationPlayerStartBuffer = Notification.Name(rawValue: "com.whatsong.bufferStart")
    public static let wsNotificationPlayerFinishBuffer = Notification.Name(rawValue: "com.whatsong.bufferFinish")
}

let APP_DELEGATE = (UIApplication.shared.delegate as! AppDelegate)

