//
//  GSMessage.swift
//  GSMessages
//
//  Created by Gesen on 15/7/10.
//  Copyright (c) 2015年 Gesen. All rights reserved.
//

import UIKit

public enum GSMessageType {
    case Success
    case Error
    case Warning
    case Info
}

public enum GSMessagePosition {
    case Top
    case Bottom
}

public enum GSMessageAnimation {
    case Slide
    case Fade
}

public enum GSMessageOption {
    case Animation(GSMessageAnimation)
    case AnimationDuration(NSTimeInterval)
    case AutoHide(Bool)
    case AutoHideDelay(Double) // Second
    case Height(CGFloat)
    case HideOnTap(Bool)
    case Position(GSMessagePosition)
    case TextColor(UIColor)
    case TextPadding(CGFloat)
    case TextAlignment(NSTextAlignment)
    case TextNumberOfLines(Int)
}

extension UIViewController {

    public func showMessage(text: String, type: GSMessageType, options: [GSMessageOption]?) {
        GSMessage.showMessageAddedTo(text, type: type, options: options, inView: view, inViewController: self)
    }

    public func hideMessage() {
        view.hideMessage()
    }

}

extension UIView {

    public func showMessage(text: String, type: GSMessageType, options: [GSMessageOption]?) {
        GSMessage.showMessageAddedTo(text, type: type, options: options, inView: self, inViewController: nil)
    }

    public func hideMessage() {
        installedMessage?.hide()
    }

}

public class GSMessage {

    public static var font : UIFont = UIFont.systemFontOfSize(14)
    public static var successBackgroundColor : UIColor = UIColor(red: 142.0/255, green: 183.0/255, blue: 64.0/255,  alpha: 0.95)
    public static var warningBackgroundColor : UIColor = UIColor(red: 230.0/255, green: 189.0/255, blue: 1.0/255,   alpha: 0.95)
    public static var errorBackgroundColor   : UIColor = UIColor(red: 219.0/255, green: 36.0/255,  blue: 27.0/255,  alpha: 0.70)
    public static var infoBackgroundColor    : UIColor = UIColor(red: 44.0/255,  green: 187.0/255, blue: 255.0/255, alpha: 0.90)

    public class func showMessageAddedTo(text: String, type: GSMessageType, options: [GSMessageOption]?, inView: UIView, inViewController: UIViewController?) {
        if inView.installedMessage != nil && inView.uninstallMessage == nil { inView.hideMessage() }
        if inView.installedMessage == nil {
            GSMessage(text: text, type: type, options: options, inView: inView, inViewController: inViewController).show()
        }
    }

    public func show() {

        if inView?.installedMessage != nil { return }
        
        updateFrames()

        inView?.installedMessage = self
        inView?.addSubview(messageView)

        if animation == .Fade {
            messageView.alpha = 0
            UIView.animateWithDuration(animationDuration) { self.messageView.alpha = 1 }
        }

        else if animation == .Slide && position == .Top {
            messageView.transform = CGAffineTransformMakeTranslation(0, -messageHeight)
            UIView.animateWithDuration(animationDuration) { self.messageView.transform = CGAffineTransformMakeTranslation(0, 0) }
        }

        else if animation == .Slide && position == .Bottom {
            messageView.transform = CGAffineTransformMakeTranslation(0, height)
            UIView.animateWithDuration(animationDuration) { self.messageView.transform = CGAffineTransformMakeTranslation(0, 0) }
        }

        if autoHide { GS_GCDAfter(autoHideDelay) { self.hide() } }

    }

    public func hide() {

        if inView?.installedMessage !== self || inView?.uninstallMessage != nil { return }

        inView?.uninstallMessage = self
        inView?.installedMessage = nil

        if animation == .Fade {
            UIView.animateWithDuration(self.animationDuration,
                animations: { [weak self] in if let this = self { this.messageView.alpha = 0 } },
                completion: { [weak self] finished in self?.removeFromSuperview() }
            )
        }

        else if animation == .Slide && position == .Top {
            UIView.animateWithDuration(self.animationDuration,
                animations: { [weak self] in if let this = self { this.messageView.transform = CGAffineTransformMakeTranslation(0, -this.messageHeight) } },
                completion: { [weak self] finished in self?.removeFromSuperview() }
            )
        }

        else if animation == .Slide && position == .Bottom {
            UIView.animateWithDuration(self.animationDuration,
                animations: { [weak self] in if let this = self { this.messageView.transform = CGAffineTransformMakeTranslation(0, this.height) } },
                completion: { [weak self] finished in self?.removeFromSuperview() }
            )
        }

    }

    public private(set) weak var inView: UIView!
    public private(set) weak var inViewController: UIViewController?
    public private(set) var messageView: UIView!
    public private(set) var messageText: UILabel!
    public private(set) var animation: GSMessageAnimation = .Slide
    public private(set) var animationDuration: NSTimeInterval = 0.3
    public private(set) var autoHide: Bool = true
    public private(set) var autoHideDelay: Double = 3
    public private(set) var backgroundColor: UIColor!
    public private(set) var height: CGFloat = 44
    public private(set) var hideOnTap: Bool = true
    public private(set) var offsetY: CGFloat = 0
    public private(set) var position: GSMessagePosition = .Top
    public private(set) var textColor: UIColor = UIColor.whiteColor()
    public private(set) var textPadding: CGFloat = 30
    public private(set) var textAlignment: NSTextAlignment = .Center
    public private(set) var textNumberOfLines: Int = 1
    public private(set) var y: CGFloat = 0

    public var messageHeight: CGFloat { return offsetY + height }

    public init(text: String, type: GSMessageType, options: [GSMessageOption]?, inView: UIView, inViewController: UIViewController?) {

        var inView = inView
        
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
                case let .HideOnTap(value): hideOnTap = value
                case let .Position(value): position = value
                case let .TextColor(value): textColor = value
                case let .TextPadding(value): textPadding = value
                case let .TextAlignment(value): textAlignment = value
                case let .TextNumberOfLines(value): textNumberOfLines = value
                }
            }
        }

        if inViewController is UITableViewController {
            if let lastWindow = UIApplication.sharedApplication().windows.last {
                inView = lastWindow as UIView
            }
        }

        messageView = UIView()
        messageView.backgroundColor = backgroundColor

        messageText = UILabel()
        messageText.text = text
        messageText.font = GSMessage.font
        messageText.textColor = textColor
        messageText.textAlignment = textAlignment
        messageText.numberOfLines = textNumberOfLines
        messageView.addSubview(messageText)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(updateFrames), name: UIDeviceOrientationDidChangeNotification, object: nil)
        
        if hideOnTap { messageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))) }

        self.inView = inView
        self.inViewController = inViewController
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    @objc private func handleTap(tapGesture: UITapGestureRecognizer) {
        hide()
    }
    
    @objc private func updateFrames() {
        y       = 0
        offsetY = 0
        
        switch position {
        case .Top:
            if let viewController = inViewController {
                let navigation = viewController.navigationController ?? (viewController as? UINavigationController)
                let navigationBarHidden = (navigation?.navigationBarHidden ?? true)
                let navigationBarTranslucent = (navigation?.navigationBar.translucent ?? false)
                let navigationBarHeight = (navigation?.navigationBar.frame.size.height ?? 44)
                let statusBarHidden = UIApplication.sharedApplication().statusBarHidden
                if !navigationBarHidden && navigationBarTranslucent && !statusBarHidden { offsetY+=20 }
                if !navigationBarHidden && navigationBarTranslucent { offsetY+=navigationBarHeight }
                if (navigationBarHidden && !statusBarHidden) { offsetY+=20 }
            }
        case .Bottom:
            y = inView.bounds.size.height - height
        }
        
        messageView.frame     = CGRect(x: 0, y: y, width: inView.bounds.size.width, height: messageHeight)
        messageText.frame = CGRect(x: textPadding, y: offsetY, width: messageView.bounds.size.width - textPadding * 2, height: height)
    }

    private func removeFromSuperview() {
        messageView.removeFromSuperview()
        inView?.uninstallMessage = nil
    }

}

extension UIView {

    private var installedMessage: GSMessage? {
        get { return objc_getAssociatedObject(self, &installedMessageKey) as? GSMessage }
        set { objc_setAssociatedObject(self, &installedMessageKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    private var uninstallMessage: GSMessage? {
        get { return objc_getAssociatedObject(self, &uninstallMessageKey) as? GSMessage }
        set { objc_setAssociatedObject(self, &uninstallMessageKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

}

private var installedMessageKey = ""
private var uninstallMessageKey = ""

private func GS_GCDAfter(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}
