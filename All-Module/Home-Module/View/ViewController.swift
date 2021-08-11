//
//  ViewController.swift
//  MobiquityDemo
//
//  Created by Shailendra Kumar Gupta on 10/08/21.
//  Copyright © 2020 Shailendra Kumar Gupta. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: BaseVC {

    var locationManager:CLLocationManager!
    @IBOutlet weak var searchBar : UISearchBar!
    @IBOutlet weak var tblSearch : UITableView!
    @IBOutlet weak var mapView   : MKMapView!
    var objHomeVM   = HomeVM()
    let newPin = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = TitleName.kHome;
        self.objHomeVM = HomeVM()
        self.SetUpCurrentLocation()
        self.objHomeVM.setupUI(self.searchBar, self.tblSearch)
        self.objHomeVM.selectCell = { (cityName) in
            self.MoveToCity(cityName)
        }
    }
    func SetUpCurrentLocation(){
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            self.locationManager.startUpdatingLocation()
        }
    }
}
//===================================
//MARK:- CLLocationManagerDelegate
//===================================
extension ViewController : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation :CLLocation = locations[0] as CLLocation
        
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")

        let location: CLLocation = locations.first!
        self.mapView.centerCoordinate = location.coordinate
        let reg = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1500, longitudinalMeters: 1500)
        self.mapView.setRegion(reg, animated: true)
        
        self.mapView.removeAnnotation(newPin)
        let location1 = locations.last! as CLLocation
        let center = CLLocationCoordinate2D(latitude: location1.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        //set region on the map
        self.mapView.setRegion(region, animated: true)
        self.newPin.coordinate = location.coordinate
        self.mapView.addAnnotation(self.newPin)
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
}


