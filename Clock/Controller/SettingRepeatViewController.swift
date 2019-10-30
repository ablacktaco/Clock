//
//  SettingRepeatViewController.swift
//  Clock
//
//  Created by 陳姿穎 on 2019/10/28.
//  Copyright © 2019 陳姿穎. All rights reserved.
//

import UIKit

class SettingRepeatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let userData = UserData.shared
    let weekdays = ["Every Sunday", "Every Monday", "Every Tuesday", "Every Wednesday", "Every Thursday", "Every Friday", "Every Saturday"]
    let weeks = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weekdays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weekdaysCell", for: indexPath)
        cell.textLabel?.text = weekdays[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        cell.accessoryType = userData.tempAlarm!.alarmRepeatState[indexPath.row] ? .checkmark : .none
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .orange
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        userData.tempAlarm?.alarmRepeatState[indexPath.row].toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        let condition = userData.tempAlarm!.alarmRepeatState
        var repeatDay: String {
            if condition == Array(repeating: false, count: 7) {
                return " Never"
            } else if condition == Array(repeating: true, count: 7) {
                return " Everyday"
            } else if condition == [true, true, true, true, true, false, false] {
                return " Weekdays"
            } else if condition == [false, false, false, false, false, true, true] {
                return " Weekends"
            } else {
                var repeatDay = ""
                for i in 0..<condition.count {
                    if condition[i] {
                        repeatDay = repeatDay + " " + weeks[i]
                    }
                }
                return repeatDay
            }
        }
        userData.tempAlarm?.alarmRepeat = repeatDay
    }
}
