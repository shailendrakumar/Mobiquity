//
//  CityCollectionCell.swift
//  MobiquityDemo
//
//  Created by Shailendra Kumar Gupta on 10/08/21.
//  Copyright © 2020 Shailendra Kumar Gupta. All rights reserved.
//

import UIKit

class CityCell: UICollectionViewCell {
    
    @IBOutlet weak var temperatureLabel : UILabel!
    @IBOutlet weak var humidityLabel    : UILabel!
    @IBOutlet weak var windLabel        : UILabel!
    @IBOutlet weak var visibiltyLabel   : UILabel!
    @IBOutlet weak var pressureLabel    : UILabel!
    @IBOutlet weak var mainWetherLabel  : UILabel!
    @IBOutlet weak var DescnWetherLabel : UILabel!
    @IBOutlet weak var DateLabel        : UILabel!
    @IBOutlet weak var TimeLabel        : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
