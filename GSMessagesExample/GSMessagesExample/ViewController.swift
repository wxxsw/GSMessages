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
        showMessage("Some message", type: .info, options: [
            .handleTap({
                print("Custom tap handle")
            })
        ])
    }
    
    @IBAction func tapEndless(_ sender: AnyObject) {
        showMessage("Endless", type: .success, options: [
            .autoHide(false),
            .hideOnTap(false)
        ])
    }
    
    @IBAction func tapDismiss(_ sender: AnyObject) {
        hideMessage()
        someView.hideMessage()
    }
    
    @IBAction func tapFade(_ sender: AnyObject) {
        showMessage("Fade", type: .success, options: [.animations([.fade])])
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
    
    @IBAction func tapLongText(_ sender: AnyObject) {
        showMessage("This will be a very long message that someone wanna show in a high message", type: .success, options: [.textNumberOfLines(0)])
    }
    
    @IBAction func tapBottom(_ sender: AnyObject) {
        showMessage("Bottom", type: .success, options: [.position(.bottom)])
    }
    
    @IBAction func tapMargin(_ sender: Any) {
        someView.showMessage("Margin", type: .success, options: [
            .margin(.init(top: 20, left: 20, bottom: 0, right: 20)),
            .cornerRadius(5)
        ])
    }
    
    @IBAction func tapPadding(_ sender: Any) {
        showMessage("Padding,Padding,Padding,Padding,Padding,Padding", type: .success, options: [
            .padding(.init(top: 10, left: 50, bottom: 10, right: 0))
        ])
    }
    
    @IBAction func tapRoundedCorners(_ sender: Any) {
        showMessage("Rounded Corners", type: .success, options: [
            .cornerRadius(10),
            .margin(.init(top: 0, left: 10, bottom: 0, right: 10))
        ])
    }
    
    @IBAction func tapTopLeft(_ sender: AnyObject) {
        showMessage("TopLeft", type: .success, options: [
            .textAlignment(.topLeft),
            .height(60)
        ])
    }
    
    @IBAction func tapCenter(_ sender: AnyObject) {
        showMessage("Center", type: .success, options: [
            .textAlignment(.center),
            .height(60)
        ])
    }
    
    @IBAction func tapBottomRight(_ sender: AnyObject) {
        showMessage("BottomRight", type: .success, options: [
            .textAlignment(.bottomRight),
            .height(60)
        ])
    }
    
    @IBAction func tapWindow(_ sender: Any) {
        guard
            let window = UIApplication.shared.keyWindow
            else { return }
        
        let attributedText = NSAttributedString(
            string: "In Window",
            attributes: [
                .font: GSMessage.font,
                .paragraphStyle: NSParagraphStyle()
            ]
        )
        
        let paddingX: CGFloat = 14
        let maxWidth = view.bounds.width - 20 - paddingX * 2
        let size = attributedText.sizeToFits(CGSize(width: maxWidth, height: 20))
        let marginX = (view.bounds.width - size.width - paddingX * 2) / 2
        let marginY = (navigationController!.isNavigationBarHidden ? 0 : navigationController!.navigationBar.frame.height) + UIApplication.shared.statusBarFrame.height + 10
        
        let options: [GSMessageOption] = [
            .animations([.fade, .slide(.distance(50))]),
            .cornerRadius(16),
            .height(32),
            .margin(.init(top: marginY, left: marginX, bottom: 0, right: marginX)),
            .padding(.init(top: 6, left: paddingX, bottom: 6, right: paddingX)),
        ]
        
        GSMessage.showMessageAddedTo(
            attributedText: attributedText,
            type: .success,
            options: options,
            inView: window,
            inViewController: nil
        )
    }
    
    @IBAction func tapToggleNavBarTranslucent(_ sender: AnyObject) {
        navigationController!.navigationBar.isTranslucent = !navigationController!.navigationBar.isTranslucent
    }
    
    @IBAction func tapToggleNavBarHidden(_ sender: AnyObject) {
        navigationController!.setNavigationBarHidden(!navigationController!.isNavigationBarHidden, animated: true)
    }
    
}

private extension NSAttributedString {
    
    func sizeToFits(_ size: CGSize) -> CGSize {
        let framesetter = CTFramesetterCreateWithAttributedString(self as CFAttributedString)
        let textSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRange(), nil, size, nil)
        return textSize
    }
    
}

