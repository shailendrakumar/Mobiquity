//
//  SettingViewModel.swift
//  MobiquityDemo
//
//  Created by Shailendra Kumar Gupta on 10/08/21.
//  Copyright © 2020 Shailendra Kumar Gupta. All rights reserved.
//

import Foundation
import UIKit

class SettingVM : NSObject{
    var unitsLbl  : UILabel!
    var tempLbl   : UILabel!
    var windLbl   : UILabel!
    var switchs   : UISwitch!
    var errorMessage  : ((String)->())? = nil
    
    
    //MARK:- SETUP UI
    func setupUI(_ unitsLbl : UILabel,_ tempLbl : UILabel,_ windLbl : UILabel,_ switchs : UISwitch){
        self.unitsLbl = unitsLbl
        self.tempLbl  = tempLbl
        self.windLbl  = windLbl
        self.switchs = switchs
        if UserDefaults.standard.value(forKey: .kSETTINGS) != nil{
            let str = UserDefaults.standard.value(forKey: .kSETTINGS) as! String
            if str == .kMetric{
                self.setValue()
            }
            else{
                self.unitsLbl.text = .kImperial
                self.tempLbl.text  = .kImperialTemp
                self.windLbl.text  = .kImperialWind
                self.switchs.isOn = true
            }
        }
        else{
            self.setValue()
        }
        self.switchs.addTarget(self, action: #selector(switchChanged), for: UIControl.Event.valueChanged)
    }
    private func setValue(){
        self.unitsLbl.text = .kMetric
        self.tempLbl.text  = .kMetricTemp
        self.windLbl.text  = .kMetricWind
        self.switchs.isOn = false
    }
    @objc func switchChanged(Switch: UISwitch) {
        let value = Switch.isOn
        switch value {
        case false:self.updateValue(.kMetric, .kMetricTemp, .kMetricWind)
            UserDefaults.standard.set("Metric", forKey: .kSETTINGS)
        case true:self.updateValue(.kImperial, .kImperialTemp, .kImperialWind)
            UserDefaults.standard.set("Imperial", forKey: .kSETTINGS)
        }
    }
    private func updateValue(_ unit:String,_ temp:String,_ wind :String){
        self.unitsLbl.text = unit
        self.tempLbl.text  = temp
        self.windLbl.text  = wind
    }
}
