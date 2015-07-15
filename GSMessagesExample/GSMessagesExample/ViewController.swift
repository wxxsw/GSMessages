//
//  ViewController.swift
//  GSMessagesExample
//
//  Created by Gesen on 15/7/10.
//  Copyright (c) 2015年 Gesen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var someView: UIView!
    
    @IBAction func tapSuccess(sender: AnyObject) {
        showSuccessMessage("Something success", options: nil)
    }
    
    @IBAction func tapError(sender: AnyObject) {
        showErrorMessage("Something failed", options: nil)
    }

    @IBAction func tapWarning(sender: AnyObject) {
        showWarningMessage("Some warning", options: nil)
    }
    
    @IBAction func tapInfo(sender: AnyObject) {
        showInfoMessage("Some message", options: nil)
    }
    
    @IBAction func tapEndless(sender: AnyObject) {
        showSuccessMessage("Endless", options: [.AutoHide(false)])
    }
    
    @IBAction func tapDismiss(sender: AnyObject) {
        hideMessage()
    }
    
    @IBAction func tapFade(sender: AnyObject) {
        showSuccessMessage("Fade", options: [.Animation(.Fade)])
    }
    
    @IBAction func tapLong(sender: AnyObject) {
        showSuccessMessage("Long", options: [.AutoHideDelay(10)])
    }
    
    @IBAction func tapInView(sender: AnyObject) {
        someView.showSuccessMessage("In View", options: nil)
    }
    
    @IBAction func tapHeight(sender: AnyObject) {
        showSuccessMessage("Height", options: [.Height(100)])
    }
    
    @IBAction func tapBottom(sender: AnyObject) {
        showSuccessMessage("Bottom", options: [.Position(.Bottom)])
    }
    
}

