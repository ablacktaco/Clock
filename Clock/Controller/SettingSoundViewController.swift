//
//  SettingSoundViewController.swift
//  Clock
//
//  Created by 陳姿穎 on 2019/10/31.
//  Copyright © 2019 陳姿穎. All rights reserved.
//

import UIKit

class SettingSoundViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var soundData: [[String]] = [
        ["Vibration"],
        ["Tone Store", "Download All Purchased Tones"],
        ["Pick a song"],
        ["Radar (Default)", "Apex", "Classic"],
        ["None"]
    ]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return soundData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0..<soundData.count:
            return soundData[section].count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        fatalError()
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
