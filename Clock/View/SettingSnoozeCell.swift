//
//  SettingSnoozeCell.swift
//  Clock
//
//  Created by 陳姿穎 on 2019/10/29.
//  Copyright © 2019 陳姿穎. All rights reserved.
//

import UIKit

class SettingSnoozeCell: UITableViewCell {

    @IBOutlet var snoozeSwitch: UISwitch!
    @IBAction func toSwitchSnoozeState(_ sender: UISwitch) {
        UserData.shared.tempAlarm!.snoozeSwitch = sender.isOn
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
