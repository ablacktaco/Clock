//
//  AlarmNotificationDelegate.swift
//  Clock
//
//  Created by 陳姿穎 on 2019/10/31.
//  Copyright © 2019 陳姿穎. All rights reserved.
//

//import Foundation
//import UIKit
import UserNotifications

class AlarmNotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
        case UNNotificationDismissActionIdentifier: print("Dismiss Action")
        case UNNotificationDefaultActionIdentifier: print("Default")
        case "SnoozeAction": print("Snooze")
            let identifier = "SnoozeNotification"
            let content = response.notification.request.content
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 480, repeats: false)
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
            center.add(request, withCompletionHandler: {(error) in
                if let error = error {
                    print("\(error)")
                } else {
                    print("successed snooze")
                }
            })
        case "DeleteAction": print("Delete")
        default:
            print("Unknown action")
        }
        completionHandler()
    }
    
}
