//
//  AlarmViewController.swift
//  Clock
//
//  Created by 陳姿穎 on 2019/10/28.
//  Copyright © 2019 陳姿穎. All rights reserved.
//

import UIKit

class AlarmViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var index: Int?
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
        cell.timeLabel.text = data.alarmTime
        cell.descriptionLabel.text = "\(data.alarmLabel),\(data.alarmRepeat)"
        
        let indicator = UIImageView(frame:CGRect(x: 0, y: 0, width: 30, height: 30));
        indicator.image = UIImage(named: "Indicator")
        let switchAccessory = UISwitch()
        switchAccessory.isOn = true
        
        cell.accessoryView = tableView.isEditing ? indicator : switchAccessory
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if userData.alarmData.count == 0 {
            alarmTableView.backgroundView = tableViewBackground
            alarmTableView.separatorStyle = .none
        } else {
            alarmTableView.backgroundView = UIView()
            alarmTableView.separatorStyle = .singleLine
        }
        alarmTableView.tableFooterView = UIView()
        
        alarmTableView.allowsSelection = false
        alarmTableView.allowsSelectionDuringEditing = true
        let b = UINavigationBarAppearance()
//        b.configureWithDefaultBackground()
        navigationItem.scrollEdgeAppearance = b
        navigationController?.navigationBar.scrollEdgeAppearance = b
        navigationController?.navigationBar.standardAppearance = b
//        navigationController?.navigationBar.b
//        alarmTableView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @IBAction func becomeEditMode(_ sender: UIBarButtonItem) {
        alarmTableView.isEditing.toggle()
        editButton.title = alarmTableView.isEditing ? "Done" : "Edit"
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
        }
    }

}
