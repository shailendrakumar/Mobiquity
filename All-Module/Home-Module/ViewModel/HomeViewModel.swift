//
//  HomeViewModel.swift
//  MobiquityDemo
//
//  Created by Shailendra Kumar Gupta on 10/08/21.
//  Copyright © 2020 Shailendra Kumar Gupta. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

class HomeVM : NSObject{
    
    var searchBar    : UISearchBar!
    var tblSearch    : UITableView!
    var errorMessage : ((String)->())? = nil
    var selectCell   : ((String)->())? = nil
    var arrbookMark  = [String]()
    var newString    : String = .kEmpty
    
    func setupUI(_ searchBar : UISearchBar,_ tblSearch : UITableView){
        
        if UserDefaults.standard.value(forKey: .kBOOKMARK) != nil{
            let array = UserDefaults.standard.value(forKey: .kBOOKMARK) as! [String]
            for i in 0..<array.count {
                self.arrbookMark.append("\(array[i])")
            }
        }
        self.searchBar = searchBar
        self.searchBar.placeholder = .kEnterCityName
        self.tblSearch = tblSearch
        self.tblSearch.register(UINib(nibName: CellName.kHomeCell, bundle: nil), forCellReuseIdentifier: CellName.kHomeCell)
        self.tblSearch.dataSource = self
        self.tblSearch.delegate = self
        self.searchBar.delegate = self
    }
}
//================================
//MARK:- UITableViewDataSource
//================================
extension HomeVM: UITableViewDataSource{

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrbookMark.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblSearch.dequeueReusableCell(withIdentifier: CellName.kHomeCell) as! HomeCell
        if self.arrbookMark.count>0{
            cell.cityNameLabel.text = "\(self.arrbookMark[indexPath.row])"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectCell!("\(self.arrbookMark[indexPath.row])")
    }
}
//================================
//MARK:- UITableViewDelegate
//================================
extension HomeVM: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if self.arrbookMark.count>0{
                self.arrbookMark.remove(at: indexPath.row)
                UserDefaults.standard.set(self.arrbookMark, forKey: .kBOOKMARK)
                self.tblSearch.beginUpdates()
                self.tblSearch.deleteRows(at: [indexPath], with: .automatic)
                self.tblSearch.endUpdates()
            }
        }
    }
}
    
//============================
//MARK:- UISearchBarDelegate
//===========================
extension HomeVM : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.arrbookMark.append(self.newString)
        self.tblSearch.reloadData()
        self.searchBar.text = .kEmpty
        self.selectCell!("\(self.newString)")
        UserDefaults.standard.set(self.arrbookMark, forKey: .kBOOKMARK)
    }
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        self.newString = NSString(string: searchBar.text!).replacingCharacters(in: range, with: text)
        return true
    }
}
