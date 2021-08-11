//
//  CityVC.swift
//  MobiquityDemo
//
//  Created by Shailendra Kumar Gupta on 10/08/21.
//  Copyright © 2020 Shailendra Kumar Gupta. All rights reserved.
//

import UIKit

class CityVC: BaseVC {
   
    @IBOutlet weak var CityCollectionView : UICollectionView!
    @IBOutlet weak var mainWetherLabel    : UILabel!
    @IBOutlet weak var DescnWetherLabel   : UILabel!
    @IBOutlet weak var FeelsLikeLabel     : UILabel!
    @IBOutlet weak var temperatureLabel   : UILabel!
    @IBOutlet weak var humidityLabel      : UILabel!
    @IBOutlet weak var windLabel          : UILabel!
    @IBOutlet weak var visibiltyLabel     : UILabel!
    @IBOutlet weak var pressureLabel      : UILabel!
    @IBOutlet weak var NoPredictionLabel  : UILabel!
    
    var objCityVM  = CityVM()
    var cityName : String = .kEmpty
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.cityName
        self.objCityVM.setupUI(self.CityCollectionView, self.mainWetherLabel, self.DescnWetherLabel, self.FeelsLikeLabel, self.temperatureLabel, self.humidityLabel, self.windLabel, self.visibiltyLabel, self.pressureLabel,self.NoPredictionLabel)
        self.objCityVM.errorMessage = { (errorMsg) in
            self.ShowTheAlert(msg: errorMsg)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.objCityVM.keyword = self.cityName
        self.objCityVM.getTodayForecast()
    }
}
