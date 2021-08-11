//
//  HelpVC.swift
//  MobiquityDemo
//
//  Created by Shailendra Kumar Gupta on 10/08/21.
//  Copyright © 2020 Shailendra Kumar Gupta. All rights reserved.
//

import UIKit
import WebKit

class HelpVC: BaseVC {

    @IBOutlet weak var webView :WKWebView!
    var objHelpVM   = HelpVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = TitleName.kHelp;
        self.objHelpVM.setupUI(self.webView)
    }
}
