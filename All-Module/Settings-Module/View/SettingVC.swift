//
//  SettingVC.swift
//  MobiquityDemo
//
//  Created by Shailendra Kumar Gupta on 10/08/21.
//  Copyright © 2020 Shailendra Kumar Gupta. All rights reserved.
//

import UIKit

class SettingVC: BaseVC {

    @IBOutlet weak var unitsLbl : UILabel!
    @IBOutlet weak var tempLbl  : UILabel!
    @IBOutlet weak var windLbl  : UILabel!
    @IBOutlet weak var switchs  : UISwitch!
    var objSetting   = SettingVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = TitleName.kSetting;
        self.objSetting.setupUI(self.unitsLbl, self.tempLbl, self.windLbl, self.switchs)
    }
}
