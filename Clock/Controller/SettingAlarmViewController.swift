//
//  SettingAlarmViewController.swift
//  Clock
//
//  Created by 陳姿穎 on 2019/10/28.
//  Copyright © 2019 陳姿穎. All rights reserved.
//

import UIKit

class SettingAlarmViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var index: Int?
    let userData = UserData.shared
    var alarmViewController: AlarmViewController!
    let dateFormatter = DateFormatter()
    let titles = ["Repeat", "Label", "Sound", "Snooze"]
    
    @IBOutlet var alarmTimePicker: UIDatePicker!
    @IBOutlet var alarmDataTableView: UITableView!
    @IBOutlet var deleteAlarmButton: UIButton!
    
    @IBAction func toSaveAlarm(_ sender: UIBarButtonItem) {
        userData.tempAlarm?.alarmTime = dateFormatter.string(from: alarmTimePicker.date)
        if let index = index {
            userData.alarmData[index] = userData.tempAlarm!
        } else {
            userData.alarmData.append(userData.tempAlarm!)
        }
        alarmViewController.alarmTableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func toCancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        switch row {
        case 0...2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath)
            cell.textLabel?.text = titles[row]
            cell.textLabel?.textColor = UIColor.white
            
            switch row {
            case 0: cell.detailTextLabel?.text = userData.tempAlarm?.alarmRepeat
            case 1: cell.detailTextLabel?.text = userData.tempAlarm?.alarmLabel
            case 2: cell.detailTextLabel?.text = userData.tempAlarm?.alarmSound
            default:
                break
            }
            cell.detailTextLabel?.textColor = UIColor.lightGray

            let indicator = UIImageView(frame:CGRect(x: 0, y: 0, width: 15, height: 15));
            indicator.image = UIImage(named: "Indicator")
            cell.accessoryView = indicator
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "snoozeCell", for: indexPath)
            cell.textLabel?.text = titles[row]
            cell.textLabel?.textColor = UIColor.white
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let segueIdentifier = ["settingRepeatSegue", "settingLabelSegue"]
        performSegue(withIdentifier: segueIdentifier[indexPath.row], sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let index = index {
            userData.tempAlarm = userData.alarmData[index]
            navigationItem.title = "Edit Alarm"
        } else {
            userData.tempAlarm = AlarmData.init()
            navigationItem.title = "Add Alarm"
            deleteAlarmButton.isHidden = true
        }
        
//        navigationItem.largeTitleDisplayMode = .never
        dateFormatter.dateFormat = "h:mma"
        alarmTimePicker.setValue(UIColor.white, forKey: "textColor")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        userData.tempAlarm?.alarmLabel = PassLabel.shared.label
        alarmDataTableView.reloadData()
//        alarmDataTableView.scrollToNearestSelectedRow(at: <#T##UITableView.ScrollPosition#>, animated: <#T##Bool#>)
    }
}
