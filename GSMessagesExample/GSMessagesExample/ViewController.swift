//
//  ViewController.swift
//  GSMessagesExample
//
//  Created by Gesen on 15/7/10.
//  Copyright (c) 2015年 Gesen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tapSuccess(sender: AnyObject) {
        showSuccessMessage("Something success", options: nil)
    }

    @IBAction func tapWarning(sender: AnyObject) {
        showWarningMessage("Something warning", options: [.Position(.Bottom)])
    }
    
    @IBAction func tapError(sender: AnyObject) {
        showErrorMessage("Something failure", options: [.Animation(.Slide)])
    }
    
    @IBAction func tapInfo(sender: AnyObject) {
        showInfoMessage("Some message", options: [.Position(.Bottom), .Animation(.Slide)])
    }
    
}

