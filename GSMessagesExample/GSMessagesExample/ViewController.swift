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
        showMessage("Something success", type: .Success, options: nil)
    }
    
    @IBAction func tapError(sender: AnyObject) {
        showMessage("Something failed", type: .Error, options: nil)
    }

    @IBAction func tapWarning(sender: AnyObject) {
        showMessage("Some warning", type: .Warning, options: nil)
    }
    
    @IBAction func tapInfo(sender: AnyObject) {
        showMessage("Some message", type: .Info, options: nil)
    }
    
    @IBAction func tapEndless(sender: AnyObject) {
        showMessage("Endless", type: .Success, options: [.AutoHide(false), .HideOnTap(false)])
    }
    
    @IBAction func tapDismiss(sender: AnyObject) {
        hideMessage()
        someView.hideMessage()
    }
    
    @IBAction func tapFade(sender: AnyObject) {
        showMessage("Fade", type: .Success, options: [.Animation(.Fade)])
    }
    
    @IBAction func tapLong(sender: AnyObject) {
        showMessage("Long", type: .Success, options: [.AutoHideDelay(10)])
    }
    
    @IBAction func tapInView(sender: AnyObject) {
        someView.showMessage("In View", type: .Success, options: nil)
    }
    
    @IBAction func tapHeight(sender: AnyObject) {
        showMessage("Height", type: .Success, options: [.Height(100)])
    }
    
    @IBAction func tapLeft(sender: AnyObject) {
        showMessage("Left", type: .Success, options: [.TextAlignment(.Left)])
    }
    
    @IBAction func tapCenter(sender: AnyObject) {
        showMessage("center", type: .Success, options: [.TextAlignment(.Center)])
    }
    
    @IBAction func tapRight(sender: AnyObject) {
        showMessage("Right", type: .Success, options: [.TextAlignment(.Right)])
    }
    
    @IBAction func tapVeryLong(sender: AnyObject) {
        showMessage("This will be a very long message that someone wanna show in a high message", type: .Success, options: [.Height(100), .TextNumberOfLines(2)])
    }
    
    @IBAction func tapBottom(sender: AnyObject) {
        showMessage("Bottom", type: .Success, options: [.Position(.Bottom)])
    }
    
    @IBAction func tapToggleNavBarTranslucent(sender: AnyObject) {
        navigationController!.navigationBar.translucent = !navigationController!.navigationBar.translucent
    }
    
    @IBAction func tapToggleNavBarHidden(sender: AnyObject) {
        navigationController!.setNavigationBarHidden(!navigationController!.navigationBarHidden, animated: true)
    }
    
}

