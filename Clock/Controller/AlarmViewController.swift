//
//  AlarmViewController.swift
//  Clock
//
//  Created by 陳姿穎 on 2019/10/28.
//  Copyright © 2019 陳姿穎. All rights reserved.
//

import UIKit

class AlarmViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let userData = UserData.shared
    @IBOutlet var alarmTableView: UITableView!
    @IBOutlet var tableViewBackground: UIView!
    @IBOutlet var editButton: UIBarButtonItem!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userData.alarmData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "alarmCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AlarmCell
        
        let data = userData.alarmData[indexPath.row]
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "h:mma"
        
        let dateComponents = DateComponents(calendar: Calendar.current, hour: data.alarmTime.alarmHour, minute: data.alarmTime.alarmMinute)
        
        cell.timeLabel.text = dateFormatter.string(from: dateComponents.date!)
        if data.alarmSwitch == false {
            cell.timeLabel.textColor = .lightGray
        }
        if data.alarmRepeat == "Never" {
            cell.descriptionLabel.text = "\(data.alarmLabel)"
        } else {
            cell.descriptionLabel.text = "\(data.alarmLabel),\(data.alarmRepeat)"
        }
        
        let accessorySwitch = UISwitch()
//        accessorySwitch.tag = indexPath.row
        accessorySwitch.isOn = data.alarmSwitch
//        accessorySwitch.addTarget(self, action: #selector(toChangeAlarmState(_:)), for: .valueChanged)
        cell.accessoryView = accessorySwitch
        
        let indicator = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        indicator.image = UIImage(named: "Indicator")
        cell.editingAccessoryView = indicator
        
        return cell
    }
    
    fileprivate func setTableBackground() {
        if userData.alarmData.count == 0 {
            alarmTableView.backgroundView = tableViewBackground
            alarmTableView.separatorStyle = .none
        } else {
            alarmTableView.backgroundView = UIView()
            alarmTableView.separatorStyle = .singleLine
        }
    }
    
//    @objc func toChangeAlarmState(_ sender: UISwitch) {
//        userData.alarmData[sender.tag].alarmSwitch.toggle()
//        alarmTableView.reloadRows(at: [[sender.tag, 0]], with: .fade)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableBackground()
        alarmTableView.tableFooterView = UIView()
        
        alarmTableView.allowsSelection = false
        alarmTableView.allowsSelectionDuringEditing = true
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @IBAction func becomeEditMode(_ sender: UIBarButtonItem) {
        alarmTableView.isEditing.toggle()
        editButton.title = alarmTableView.isEditing ? "Done" : "Edit"
        alarmTableView.reloadData()
    }
    
    @IBAction func addAlarm(_ sender: UIBarButtonItem) {
        if let settingAlarmNavigation = storyboard?.instantiateViewController(withIdentifier: "settingAlarmNavigation") as? UINavigationController {
            if let destination = settingAlarmNavigation.viewControllers.first as? SettingAlarmViewController {
                destination.index = nil
                destination.alarmViewController = self
                present(settingAlarmNavigation, animated: true, completion: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let settingAlarmNavigation = storyboard?.instantiateViewController(withIdentifier: "settingAlarmNavigation") as? UINavigationController {
            if let destination = settingAlarmNavigation.viewControllers.first as? SettingAlarmViewController {
                destination.index = indexPath.row
                destination.alarmViewController = self
                present(settingAlarmNavigation, animated: true, completion: nil)
            }
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            userData.alarmData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            setTableBackground()
        }
    }

}
