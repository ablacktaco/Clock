//
//  SettingLabelViewController.swift
//  Clock
//
//  Created by 陳姿穎 on 2019/10/28.
//  Copyright © 2019 陳姿穎. All rights reserved.
//

import UIKit

class SettingLabelViewController: UIViewController, UITextFieldDelegate {
    
    let userData = UserData.shared
    @IBOutlet var alarmLabelTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .orange
        
        alarmLabelTextField.becomeFirstResponder()
        alarmLabelTextField.text = userData.tempAlarm!.alarmLabel
        alarmLabelTextField.clearButtonMode = .always
        alarmLabelTextField.enablesReturnKeyAutomatically = true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        navigationController?.popViewController(animated: true)
        return true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        if alarmLabelTextField.text != "" {
            userData.tempAlarm!.alarmLabel = alarmLabelTextField.text!
        }
    }
    
}
