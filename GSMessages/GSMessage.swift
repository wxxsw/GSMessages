//
//  GSMessage.swift
//  GSMessagesExample
//
//  Created by Gesen on 15/7/10.
//  Copyright (c) 2015年 Gesen. All rights reserved.
//

import UIKit

enum GSMessageType {
    case Success
    case Error
    case Warning
    case Info
}

enum GSMessagePosition {
    case Top
    case Bottom
}

enum GSMessageAnimation {
    case Slide
    case Fade
}

enum GSMessageOption {
    case Animation(GSMessageAnimation)
    case AnimationDuration(NSTimeInterval)
    case AutoHide(Bool)
    case AutoHideDelay(Double) // Second
    case Height(CGFloat)
    case Position(GSMessagePosition)
    case TextColor(UIColor)
}

extension UIViewController {
    
    func showMessage(text: String, type: GSMessageType, options: [GSMessageOption]?) {
        view.showMessage(text, type: type, options: options)
    }
    
    func hideMessage() {
        view.hideMessage()
    }
    
}

extension UIView {
    
    func showMessage(text: String, type: GSMessageType, options: [GSMessageOption]?) {
        GSMessage.showMessageAddedTo(self, text: text, type: type, options: options)
    }
    
    func hideMessage() {
        installedMessage?.hide()
    }
    
}

class GSMessage {
    
    static var font: UIFont = UIFont.systemFontOfSize(14)
    static var successBackgroundColor: UIColor = UIColor(red: 142.0/255, green: 183.0/255, blue: 64.0/255, alpha: 0.95)
    static var warningBackgroundColor: UIColor = UIColor(red: 230.0/255, green: 189.0/255, blue: 1.0/255, alpha: 0.95)
    static var errorBackgroundColor: UIColor = UIColor(red: 219.0/255, green: 36.0/255, blue: 27.0/255, alpha: 0.70)
    static var infoBackgroundColor: UIColor = UIColor(red: 44.0/255, green: 187.0/255, blue: 255.0/255, alpha: 0.90)
    
    class func showMessageAddedTo(view: UIView, text: String, type: GSMessageType, options: [GSMessageOption]?) {
        if view.installedMessage != nil && view.uninstallMessage == nil { view.hideMessage() }
        if view.installedMessage == nil {
            GSMessage(view: view, text: text, type: type, options: options).show()
        }
    }
    
    func show() {
        
        if view?.installedMessage != nil { return }
        
        view?.installedMessage = self
        view?.addSubview(message)
        
        if animation == .Fade {
            message.alpha = 0
            UIView.animateWithDuration(animationDuration) { self.message.alpha = 1 }
        }
            
        else if animation == .Slide && position == .Top {
            message.transform = CGAffineTransformMakeTranslation(0, -height)
            UIView.animateWithDuration(animationDuration) { self.message.transform = CGAffineTransformMakeTranslation(0, 0) }
        }
            
        else if animation == .Slide && position == .Bottom {
            message.transform = CGAffineTransformMakeTranslation(0, height)
            UIView.animateWithDuration(animationDuration) { self.message.transform = CGAffineTransformMakeTranslation(0, 0) }
        }
        
        if autoHide { GCDAfter(autoHideDelay) { self.hide() } }
        
    }
    
    func hide() {
        
        if view?.installedMessage !== self || view?.uninstallMessage != nil { return }
        
        view?.uninstallMessage = self
        view?.installedMessage = nil
        
        if animation == .Fade {
            UIView.animateWithDuration(self.animationDuration,
                animations: { [weak self] in if let this = self { this.message.alpha = 0 } },
                completion: { [weak self] finished in self?.removeFromSuperview() }
            )
        }
            
        else if animation == .Slide && position == .Top {
            UIView.animateWithDuration(self.animationDuration,
                animations: { [weak self] in if let this = self { this.message.transform = CGAffineTransformMakeTranslation(0, -this.height) } },
                completion: { [weak self] finished in self?.removeFromSuperview() }
            )
        }
            
        else if animation == .Slide && position == .Bottom {
            UIView.animateWithDuration(self.animationDuration,
                animations: { [weak self] in if let this = self { this.message.transform = CGAffineTransformMakeTranslation(0, this.height) } },
                completion: { [weak self] finished in self?.removeFromSuperview() }
            )
        }
        
    }
    
    private weak var view: UIView?
    private var message: UIView!
    private var messageText: UILabel!
    private var animation: GSMessageAnimation = .Slide
    private var animationDuration: NSTimeInterval = 0.3
    private var autoHide: Bool = true
    private var autoHideDelay: Double = 3
    private var backgroundColor: UIColor!
    private var height: CGFloat = 44
    private var position: GSMessagePosition = .Top
    private var textColor: UIColor = UIColor.whiteColor()
    private var y: CGFloat = 0
    
    private init(view: UIView, text: String, type: GSMessageType, options: [GSMessageOption]?) {
        
        switch type {
        case .Success:  backgroundColor = GSMessage.successBackgroundColor
        case .Warning:  backgroundColor = GSMessage.warningBackgroundColor
        case .Error:    backgroundColor = GSMessage.errorBackgroundColor
        case .Info:     backgroundColor = GSMessage.infoBackgroundColor
        }
        
        if let options = options {
            for option in options {
                switch (option) {
                case let .Animation(value): animation = value
                case let .AnimationDuration(value): animationDuration = value
                case let .AutoHide(value): autoHide = value
                case let .AutoHideDelay(value): autoHideDelay = value
                case let .Height(value): height = value
                case let .Position(value): position = value
                case let .TextColor(value): textColor = value
                }
            }
        }
        
        switch position {
        case .Top:      y = 0
        case .Bottom:   y = view.bounds.size.height - height
        }
        
        message = UIView(frame: CGRect(x: 0, y: y, width: view.bounds.size.width, height: height))
        message.backgroundColor = backgroundColor
        
        messageText = UILabel(frame: message.bounds)
        messageText.text = text
        messageText.font = GSMessage.font
        messageText.textColor = textColor
        messageText.textAlignment = .Center
        message.addSubview(messageText)
        
        self.view = view
    }
    
    private func removeFromSuperview() {
        message.removeFromSuperview()
        view?.uninstallMessage = nil
    }
    
}

extension UIView {
    
    var installedMessage: GSMessage? {
        get { return objc_getAssociatedObject(self, &installedMessageKey) as? GSMessage }
        set { objc_setAssociatedObject(self, &installedMessageKey, newValue, UInt(OBJC_ASSOCIATION_RETAIN_NONATOMIC)) }
    }
    
    var uninstallMessage: GSMessage? {
        get { return objc_getAssociatedObject(self, &uninstallMessageKey) as? GSMessage }
        set { objc_setAssociatedObject(self, &uninstallMessageKey, newValue, UInt(OBJC_ASSOCIATION_RETAIN_NONATOMIC)) }
    }
    
}

private var installedMessageKey = ""
private var uninstallMessageKey = ""

private func GCDAfter(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}
