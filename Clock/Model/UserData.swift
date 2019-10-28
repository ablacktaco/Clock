//
//  UserData.swift
//  Clock
//
//  Created by 陳姿穎 on 2019/10/28.
//  Copyright © 2019 陳姿穎. All rights reserved.
//

import Foundation

class UserData {
    
    static var shared = UserData()
    
    var tempAlarm: AlarmData?
    
    var alarmData: [AlarmData] {
        didSet {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(self.alarmData), forKey: "alarmData")
        }
    }
    
    private static func getAlarmData() -> [AlarmData] {
        if let alarmData = UserDefaults.standard.object(forKey: "alarmData") as? Data {
            if let data = try? PropertyListDecoder().decode([AlarmData].self, from: alarmData) { return data }
        }
        return []
    }
    
    var defaultAlarmSound: String {
        didSet {
            UserDefaults.standard.set(self.defaultAlarmSound, forKey: "defaultAlarmSound")
        }
    }
    
    private static func getDefaultAlarmSound() -> String {
        if let sound = UserDefaults.standard.value(forKey: "defaultAlarmSound") as? String { return sound }
        return "Radar"
    }
    
    private init() {
        alarmData = UserData.getAlarmData()
        defaultAlarmSound = UserData.getDefaultAlarmSound()
    }
    
}
