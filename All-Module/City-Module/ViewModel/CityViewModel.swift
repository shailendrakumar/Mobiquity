//
//  CityViewMode.swift
//  MobiquityDemo
//
//  Created by Shailendra Kumar Gupta on 10/08/21.
//  Copyright © 2020 Shailendra Kumar Gupta. All rights reserved.
//

import Foundation
import UIKit

class CityVM : NSObject{
    
    var CityCollectionView : UICollectionView!
    var mainWetherLabel    : UILabel!
    var DescnWetherLabel   : UILabel!
    var FeelsLikeLabel     : UILabel!
    var temperatureLabel   : UILabel!
    var humidityLabel      : UILabel!
    var windLabel          : UILabel!
    var visibiltyLabel     : UILabel!
    var pressureLabel      : UILabel!
    var NoPredictionLabel  : UILabel!
    var errorMessage       : ((String)->())? = nil
    var successMessage     : ((String)->())? = nil
    var API                = WebService()
    var TodayForecaseData  : TodayForecaseCodable!
    var FiveDaysForecaseData : FiveDaysForecaseCodable!
    var apitype            : ApiType!
    var Lists              = [List]()
    var keyword : String = .kEmpty,settingsValue : String = .kEmpty
    var ResponseDic = NSDictionary()
    var listArray = NSArray()
    
    func setupUI(_ CityCollectionView : UICollectionView,_ mainWetherLabel: UILabel,_ DescnWetherLabel: UILabel,_ FeelsLikeLabel: UILabel,_ temperatureLabel: UILabel,_ humidityLabel: UILabel,_ windLabel: UILabel,_ visibiltyLabel: UILabel,_ pressureLabel: UILabel,_ NoPredictionLabel: UILabel){
        
        self.mainWetherLabel = mainWetherLabel
        self.DescnWetherLabel = DescnWetherLabel
        self.FeelsLikeLabel = FeelsLikeLabel
        self.temperatureLabel = temperatureLabel
        self.humidityLabel = humidityLabel
        self.windLabel = windLabel
        self.visibiltyLabel = visibiltyLabel
        self.pressureLabel  = pressureLabel
        self.NoPredictionLabel  = NoPredictionLabel
        self.API.delegate = self
        self.CityCollectionView = CityCollectionView
        self.CityCollectionView.delegate = self
        self.CityCollectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        self.CityCollectionView.setCollectionViewLayout(layout, animated: true)
        self.CityCollectionView.register(UINib(nibName: CellName.kCityCell, bundle: nil), forCellWithReuseIdentifier: CellName.kCityCell)

        if UserDefaults.standard.value(forKey: .kSETTINGS) != nil{
            self.settingsValue = UserDefaults.standard.value(forKey: .kSETTINGS) as! String
            self.apitype = ApiType.TodayForecast
            Spinner.start()
            switch self.settingsValue {
            case .kImperial:
                self.settingsValue = .kImperial
            case .kMetric:
                self.settingsValue = .kMetric
            default:break
            }
        }
        else{
            self.settingsValue = .kMetric
        }
    }
    
    //MARK:- TodayForecast WEB SERVICE CALL
    func getTodayForecast()  {
        self.apitype = ApiType.TodayForecast
        Spinner.start()
        var allowedQueryParamAndKey = NSCharacterSet.urlQueryAllowed
        allowedQueryParamAndKey.remove(charactersIn: ";/?:@&=+$, ")
        self.keyword = self.keyword.replacingOccurrences(of: "\n", with: "")
        let Url = WebServiceName.kTodayForecastAPI + "\(self.keyword.addingPercentEncoding(withAllowedCharacters: allowedQueryParamAndKey)!)" + "&appid=\(Environment.APIKey)" + "&units=\(self.settingsValue)"
        self.API.APICall(Url, .POST, nil)
    }
    //MARK:- FiveDaysForecast WEB SERVICE CALL
    func getFiveDaysForecast()  {
        self.apitype = ApiType.FiveDaysForecast
        Spinner.start()
        var allowedQueryParamAndKey = NSCharacterSet.urlQueryAllowed
        allowedQueryParamAndKey.remove(charactersIn: ";/?:@&=+$, ")
        self.keyword = self.keyword.replacingOccurrences(of: "\n", with: "")
        let Url = WebServiceName.kFiveDaysForecastAPI + "\(self.keyword.addingPercentEncoding(withAllowedCharacters: allowedQueryParamAndKey)!)" + "&appid=\(Environment.APIKey)" + "&units=\(self.settingsValue)"
        self.API.APICall(Url, .POST, nil)
    }
}

//==============================
//MARK:- WebServiceDelegate
//==============================
extension CityVM : WebServiceDelegate{
    func getResponse(result: Data) {
        DispatchQueue.main.async {
            Spinner.stop()
        }
        if self.apitype ==   ApiType.TodayForecast{
            guard let TodayForecaseData = try? JSONDecoder().decode(TodayForecaseCodable.self, from: result) else {return}
            self.TodayForecaseData = TodayForecaseData
            DispatchQueue.main.async {
                if self.TodayForecaseData.cod == 200{
                    let MainWeather = self.TodayForecaseData.weather![0]
                    let Winds = self.TodayForecaseData.wind
                    let Mains = self.TodayForecaseData.main
                    self.mainWetherLabel.text = MainWeather.main ?? .kEmpty
                    self.DescnWetherLabel.text = MainWeather.description ?? .kEmpty
                    self.NoPredictionLabel.text = .kNoPreciptation
                    switch self.settingsValue {
                    case .kImperial:
                        self.FeelsLikeLabel.text = "Feels like \(Int(Mains?.feels_like ?? 0))" + .kImperialTemp
                        self.temperatureLabel.text = "\(Int(Mains?.temp ?? 0))" + .kImperialTemp
                        self.windLabel.text = "Wind: \(Winds?.speed ?? 0)"  + .kImperialWind
                    case .kMetric:
                        self.FeelsLikeLabel.text = "Feels like \(Int(Mains?.feels_like ?? 0))" + .kMetricTemp
                        self.temperatureLabel.text = "\(Int(Mains?.temp ?? 0))" + .kMetricTemp
                        self.windLabel.text = "Wind: \(Winds?.speed ?? 0)" + .kMetricWind
                    default:break
                    }
                    self.humidityLabel.text = "Humidity: \(Mains?.humidity ?? 0)%"
                    self.visibiltyLabel.text = "Visibilty: \(Double(self.TodayForecaseData.visibility!)/1000.0)km"
                    self.pressureLabel.text = "Pressure: \(Mains?.pressure ?? 0)hPa"
                    self.getFiveDaysForecast()
                }else{
                    self.errorMessage!(.kSomethingWrong)
                }
            }
        }
        else{
            do {
                if let json = try JSONSerialization.jsonObject(with: result, options: []) as? NSDictionary {
                    self.ResponseDic = json
                    self.listArray = self.ResponseDic.value(forKey: "list") as! NSArray
                }
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
                self.errorMessage!("Something went wrong")
            }
            DispatchQueue.main.async {
                self.CityCollectionView.reloadData()
            }
           
        }
    }
    func getErrorResponse(error: NSString) {
        DispatchQueue.main.async {
            Spinner.stop()
            self.errorMessage!((error) as String)
        }
    }
}
//===============================================================
// MARK: - UICollectionViewDelegate,UICollectionViewDataSource
//===============================================================
extension CityVM : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.ResponseDic.count > 0 {
            return self.listArray.count
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellName.kCityCell, for: indexPath) as! CityCell
        
        if self.listArray.count > 0 {
            let Dic = self.listArray[indexPath.item] as! NSDictionary
            
            let Mains = Dic.value(forKey:"main") as! NSDictionary
            let Winds = Dic.value(forKey:"wind") as! NSDictionary
            let Weathers = Dic.value(forKey:"weather") as! NSArray
            let Visibility = Dic.value(forKey:"visibility") as! Int
            let DateTime = Dic.value(forKey:"dt_txt")  as! String
            let Split = DateTime.components(separatedBy: " ")
            switch self.settingsValue {
            case .kImperial:
                cell.temperatureLabel.text =  "\(String(describing: Mains.value(forKey:"temp")!))" + .kImperialTemp
                cell.windLabel.text = "Wind: \(Winds.value(forKey:"speed") ?? 0)"  + .kImperialWind
            case .kMetric:
                cell.temperatureLabel.text = "\(String(describing: Mains.value(forKey:"temp")!))" + .kMetricTemp
                cell.windLabel.text = "Wind:  \(Winds.value(forKey:"speed") ?? 0)" + .kMetricWind
            default:break
            }
            cell.humidityLabel.text = "Humidity: \(Mains.value(forKey:"humidity") ?? 0)%"
            cell.visibiltyLabel.text = "Visibilty: \(Double(Visibility)/1000.0)km"
            cell.pressureLabel.text = "Pressure: \(Mains.value(forKey:"pressure") ?? 0) hPa"
            let  WeathersMain = Weathers[0] as! NSDictionary
            cell.mainWetherLabel.text = WeathersMain.value(forKey:"main") as? String ?? .kEmpty
            cell.DescnWetherLabel.text = WeathersMain.value(forKey:"description") as? String ?? .kEmpty
            cell.DateLabel.text = "\(Split[0])"
            cell.TimeLabel.text = "\(Split[1])"
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}
//===============================================================
// MARK: - UICollectionViewDelegateFlowLayout
//===============================================================
extension CityVM: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
}
