//
//  AppDelegate.swift
//  Clock
//
//  Created by 陳姿穎 on 2019/10/28.
//  Copyright © 2019 陳姿穎. All rights reserved.
//

import UIKit
//import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let center = UNUserNotificationCenter.current()

    let notificationDelegate = AlarmNotificationDelegate()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        center.delegate = notificationDelegate
        
        let options: UNAuthorizationOptions = [.badge, .sound, .alert]
        center.getNotificationSettings { ( settings ) in
            switch settings.authorizationStatus {
            case .notDetermined:
                self.center.requestAuthorization(options: options) {
                    (granted, error) in
                    if !granted {
                        print("Something went wrong")
                    }
                }
            case .authorized:
                DispatchQueue.main.async(execute: {
                    UIApplication.shared.registerForRemoteNotifications()
                })
            case .denied:
                print("cannot use notifications cuz the user has denied permissions")
            default: break
            }
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

