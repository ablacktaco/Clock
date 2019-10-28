//
//  AlarmData.swift
//  Clock
//
//  Created by 陳姿穎 on 2019/10/28.
//  Copyright © 2019 陳姿穎. All rights reserved.
//

import Foundation

struct AlarmData: Codable {
    
    var alarmTime: String
    var alarmRepeat: String
    var alarmRepeatState: [Bool]
    var alarmLabel: String
    var alarmSound: String
    var snoozeSwitch: Bool
    var alarmSwitch: Bool
    
    init(alarmTime: String,
         alarmRepeat: String,
         alarmRepeatState: [Bool],
         alarmLabel: String,
         alarmSound: String,
         snoozeSwitch: Bool,
         alarmSwitch: Bool) {
        self.alarmTime = alarmTime
        self.alarmRepeat = alarmRepeat
        self.alarmRepeatState = alarmRepeatState
        self.alarmLabel = alarmLabel
        self.alarmSound = alarmSound
        self.snoozeSwitch = snoozeSwitch
        self.alarmSwitch = alarmSwitch
    }
    
    init() {
        self.init(alarmTime: "",
                  alarmRepeat: "Never",
                  alarmRepeatState: Array(repeating: false, count: 7),
                  alarmLabel: "Alarm",
                  alarmSound: UserData.shared.defaultAlarmSound,
                  snoozeSwitch: true,
                  alarmSwitch: true)
    }
    
}
