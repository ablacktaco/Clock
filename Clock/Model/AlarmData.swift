//
//  AlarmData.swift
//  Clock
//
//  Created by 陳姿穎 on 2019/10/28.
//  Copyright © 2019 陳姿穎. All rights reserved.
//

import Foundation

struct AlarmData: Codable {
    
    var alarmTime: Time = Time()
    var alarmRepeat: String = "Never"
    var alarmRepeatState: [Bool] = Array(repeating: false, count: 7)
    var alarmLabel: String = "Alarm"
    var alarmSound: String
    var snoozeSwitch: Bool = true
    var alarmSwitch: Bool = true
    
    struct Time: Codable {
        var alarmHour: Int = 0
        var alarmMinute: Int = 0
    }
    
    var at: Int {
        get { alarmTime.alarmHour *  60 + alarmTime.alarmMinute }
        set {
            alarmTime.alarmHour = newValue / 60
            alarmTime.alarmMinute = newValue % 60
        }
    }
    
    init() {
        alarmSound = UserData.shared.defaultAlarmSound
    }
    
}
