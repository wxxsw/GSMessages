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
    
    @IBAction func tapSuccess(_ sender: AnyObject) {
        showMessage("Something success", type: .success)
    }
    
    @IBAction func tapError(_ sender: AnyObject) {
        showMessage("Something failed", type: .error)
    }

    @IBAction func tapWarning(_ sender: AnyObject) {
        showMessage("Some warning", type: .warning)
    }
    
    @IBAction func tapInfo(_ sender: AnyObject) {
        showMessage("Some message", type: .info)
    }
    
    @IBAction func tapEndless(_ sender: AnyObject) {
        showMessage("Endless", type: .success, options: [.autoHide(false), .hideOnTap(false)])
    }
    
    @IBAction func tapDismiss(_ sender: AnyObject) {
        hideMessage()
        someView.hideMessage()
    }
    
    @IBAction func tapFade(_ sender: AnyObject) {
        showMessage("Fade", type: .success, options: [.animation(.fade)])
    }
    
    @IBAction func tapLongTime(_ sender: AnyObject) {
        showMessage("Long Time", type: .success, options: [.autoHideDelay(10)])
    }
    
    @IBAction func tapInView(_ sender: AnyObject) {
        someView.showMessage("In View", type: .success)
    }
    
    @IBAction func tapHeight(_ sender: AnyObject) {
        showMessage("Height", type: .success, options: [.height(100)])
    }
    
    @IBAction func tapTopLeft(_ sender: AnyObject) {
        showMessage("TopLeft", type: .success, options: [.textAlignment(.topLeft), .height(60)])
    }
    
    @IBAction func tapTopCenter(_ sender: AnyObject) {
        showMessage("TopCenter", type: .success, options: [.textAlignment(.topCenter), .height(60)])
    }
    
    @IBAction func tapTopRight(_ sender: AnyObject) {
        showMessage("TopRight", type: .success, options: [.textAlignment(.topRight), .height(60)])
    }
    
    @IBAction func tapLeft(_ sender: AnyObject) {
        showMessage("Left", type: .success, options: [.textAlignment(.left), .height(60)])
    }
    
    @IBAction func tapCenter(_ sender: AnyObject) {
        showMessage("Center", type: .success, options: [.textAlignment(.center), .height(60)])
    }
    
    @IBAction func tapRight(_ sender: AnyObject) {
        showMessage("Right", type: .success, options: [.textAlignment(.right), .height(60)])
    }
    
    @IBAction func tapBottomLeft(_ sender: AnyObject) {
        showMessage("BottomLeft", type: .success, options: [.textAlignment(.bottomLeft), .height(60)])
    }
    
    @IBAction func tapBottomCenter(_ sender: AnyObject) {
        showMessage("BottomCenter", type: .success, options: [.textAlignment(.bottomCenter), .height(60)])
    }
    
    @IBAction func tapBottomRight(_ sender: AnyObject) {
        showMessage("BottomRight", type: .success, options: [.textAlignment(.bottomRight), .height(60)])
    }
    
    @IBAction func tapLongText(_ sender: AnyObject) {
        showMessage("This will be a very long message that someone wanna show in a high message", type: .success, options: [.textNumberOfLines(0)])
    }
    
    @IBAction func tapBottom(_ sender: AnyObject) {
        showMessage("Bottom", type: .success, options: [.position(.bottom)])
    }
    
    @IBAction func tapToggleNavBarTranslucent(_ sender: AnyObject) {
        navigationController!.navigationBar.isTranslucent = !navigationController!.navigationBar.isTranslucent
    }
    
    @IBAction func tapToggleNavBarHidden(_ sender: AnyObject) {
        navigationController!.setNavigationBarHidden(!navigationController!.isNavigationBarHidden, animated: true)
    }
    
}

