//
//  HelpViewModel.swift
//  MobiquityDemo
//
//  Created by Shailendra Kumar Gupta on 10/08/21.
//  Copyright © 2020 Shailendra Kumar Gupta. All rights reserved.
//

import Foundation
import WebKit

class HelpVM : NSObject{
    var webView : WKWebView!
    var errorMessage : ((String)->())? = nil
    
    func setupUI(_ webView : WKWebView){
        self.webView = webView
        self.webView.navigationDelegate = self
        if let url = Bundle.main.url(forResource: "help", withExtension: "html") {
            self.webView.load(URLRequest(url: url))
        }
    }
}
//=============================
//MARK:- WKNavigationDelegate
//=============================
extension HelpVM: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Started to load")
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Finished loading")
    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
    }
}

