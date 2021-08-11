//
//  BaseVC.swift
//  MobiquityDemo
//
//  Created by Shailendra Kumar Gupta on 10/08/21.
//  Copyright © 2020 Shailendra Kumar Gupta. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //MARK:-  VIEW CONTROLLER LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //MARK:- DISMISS TO VIEW CONTROLLER
    func DISMISS(_ animated : Bool = true){
        self.dismiss(animated: animated, completion: nil)
    }
    //MARK:- POP TO VIEW CONTROLLER
    func POP(_ animated : Bool = true){
        self.navigationController?.popViewController(animated: true)
    }
    //MARK:- POP TO ROOT  VIEW CONTROLLER
    func POP_TO_ROOT(_ animated : Bool = true){
        self.navigationController?.popToRootViewController(animated: true)
    }
    //MARK:- GOTO CITY SCREEN
    public func MoveToCity(_ cityName :String){
        let VC = UIStoryboard(name: StoryboadName.kMain, bundle: nil).instantiateViewController(withIdentifier: IdentifierName.kCity) as! CityVC
        VC.cityName = cityName
        self.navigationController?.pushViewController(VC, animated: true)
    }
    //MARK:- DISPLAY ALERT FOR MESSAGE
    public func ShowTheAlert(msg:String){
        let otherAlert = UIAlertController(title: .kEmpty, message: msg, preferredStyle: UIAlertController.Style.alert)
        let Okay = UIAlertAction(title: .kOK, style: UIAlertAction.Style.default) { _ in
        }
        otherAlert.addAction(Okay)
        self.present(otherAlert, animated: true, completion: nil)
    }
}

