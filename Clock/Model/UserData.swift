//
//  UserData.swift
//  Clock
//
//  Created by 陳姿穎 on 2019/10/28.
//  Copyright © 2019 陳姿穎. All rights reserved.
//

import Foundation

class UserData {
    
    static let shared = UserData()
    
    var tempAlarm: AlarmData?
    
    var alarmData: [AlarmData] {
        didSet {
            //zx
            guard oldValue != self.alarmData else { return }
            let data = self.alarmData.sorted { $0.at < $1.at }
//            if let a = try
            UserDefaults.standard.set(try? PropertyListEncoder().encode(data), forKey: "alarmData")
        }
    }
    
    private static func getAlarmData() -> [AlarmData] {
        if let alarmData = UserDefaults.standard.object(forKey: "alarmData") as? Data {
            if let data = try? PropertyListDecoder().decode([AlarmData].self, from: alarmData) {
//                return data.sorted { $0.at < $1.at }
                return data
            }
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

extension AlarmData: Equatable {
    static func == (lhs: AlarmData, rhs: AlarmData) -> Bool {
        return lhs.alarmTime.alarmHour == rhs.alarmTime.alarmHour &&
            lhs.alarmTime.alarmMinute == rhs.alarmTime.alarmMinute &&
            lhs.alarmRepeat == rhs.alarmRepeat &&
            lhs.alarmRepeatState == rhs.alarmRepeatState &&
            lhs.alarmLabel == rhs.alarmLabel &&
            lhs.alarmSound == rhs.alarmSound &&
            lhs.snoozeSwitch == rhs.snoozeSwitch &&
            lhs.alarmSwitch == rhs.alarmSwitch
    }
}

