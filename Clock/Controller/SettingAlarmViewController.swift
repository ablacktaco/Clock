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
    let titles = ["Repeat", "Label", "Sound", "Snooze"]
    
    @IBOutlet var alarmTimePicker: UIDatePicker!
    @IBOutlet var alarmDataTableView: UITableView!
    @IBOutlet var deleteAlarmButton: UIButton!
    
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "snoozeCell", for: indexPath) as! SettingSnoozeCell
            cell.textLabel?.text = titles[row]
            cell.textLabel?.textColor = UIColor.white
            cell.snoozeSwitch.isOn = userData.tempAlarm!.snoozeSwitch
            return cell
        }
    }
    
    fileprivate func setTableBackground() {
        if userData.alarmData.count == 0 {
            alarmViewController.alarmTableView.backgroundView = alarmViewController.tableViewBackground
            alarmViewController.alarmTableView.separatorStyle = .none
        } else {
            alarmViewController.alarmTableView.backgroundView = UIView()
            alarmViewController.alarmTableView.separatorStyle = .singleLine
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mma"
        
        if let index = index {
            let alarmIndex = userData.alarmData[index]
            let dateComponents = DateComponents(calendar: Calendar.current, hour: alarmIndex.alarmTime.alarmHour, minute: alarmIndex.alarmTime.alarmMinute)
            
            userData.tempAlarm = alarmIndex
            alarmTimePicker.setDate(dateComponents.date!, animated: false)
            navigationItem.title = "Edit Alarm"
        } else {
            userData.tempAlarm = AlarmData()
            navigationItem.title = "Add Alarm"
            deleteAlarmButton.isHidden = true
        }
        
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem = backButton
        navigationItem.largeTitleDisplayMode = .never
        
        alarmTimePicker.setValue(UIColor.white, forKey: "textColor")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        alarmDataTableView.reloadData()
    }
    
    @IBAction func toSaveAlarm(_ sender: UIBarButtonItem) {
        let datecomponents = Calendar.current.dateComponents([.hour, .minute], from: alarmTimePicker.date)
        userData.tempAlarm!.alarmTime.alarmHour = datecomponents.hour!
        userData.tempAlarm!.alarmTime.alarmMinute = datecomponents.minute!
        if let index = index {
            userData.alarmData[index] = userData.tempAlarm!
        } else {
            userData.alarmData.append(userData.tempAlarm!)
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func toCancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let segueIdentifier = ["settingRepeatSegue", "settingLabelSegue"]
        performSegue(withIdentifier: segueIdentifier[indexPath.row], sender: self)
    }
    
    @IBAction func toDeleteAlarm(_ sender: UIButton) {
        userData.alarmData.remove(at: index!)
        alarmViewController.alarmTableView.deleteRows(at: [IndexPath(row: index!, section: 0)], with: .none)
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        alarmViewController.alarmTableView.isEditing = false
        alarmViewController.editButton.title = "Edit"
        alarmViewController.alarmTableView.reloadData()
        setTableBackground()
    }
    
}
