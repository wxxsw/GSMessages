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
        GSMessage.showMessageAddedTo(view, text: text, type: type, options: options, inViewController: self)
    }

    public func hideMessage() {
        view.hideMessage()
    }

}

extension UIView {

    public func showMessage(text: String, type: GSMessageType, options: [GSMessageOption]?) {
        GSMessage.showMessageAddedTo(self, text: text, type: type, options: options, inViewController: nil)
    }

    public func hideMessage() {
        installedMessage?.hide()
    }

}

public class GSMessage {

    public static var font: UIFont = UIFont.systemFontOfSize(14)
    public static var successBackgroundColor: UIColor = UIColor(red: 142.0/255, green: 183.0/255, blue: 64.0/255, alpha: 0.95)
    public static var warningBackgroundColor: UIColor = UIColor(red: 230.0/255, green: 189.0/255, blue: 1.0/255, alpha: 0.95)
    public static var errorBackgroundColor: UIColor = UIColor(red: 219.0/255, green: 36.0/255, blue: 27.0/255, alpha: 0.70)
    public static var infoBackgroundColor: UIColor = UIColor(red: 44.0/255, green: 187.0/255, blue: 255.0/255, alpha: 0.90)

    class func showMessageAddedTo(view: UIView, text: String, type: GSMessageType, options: [GSMessageOption]?, inViewController: UIViewController?) {
        if view.installedMessage != nil && view.uninstallMessage == nil { view.hideMessage() }
        if view.installedMessage == nil {
            GSMessage(view: view, text: text, type: type, options: options, inViewController: inViewController).show()
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
            message.transform = CGAffineTransformMakeTranslation(0, -messageHeight)
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
                animations: { [weak self] in if let this = self { this.message.transform = CGAffineTransformMakeTranslation(0, -this.messageHeight) } },
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
    private var hideOnTap: Bool = true
    private var offsetY: CGFloat = 0
    private var position: GSMessagePosition = .Top
    private var textColor: UIColor = UIColor.whiteColor()
    private var textPadding: CGFloat = 30
    private var textAlignment: NSTextAlignment = .Center
    private var textNumberOfLines: Int = 1
    private var y: CGFloat = 0

    private var messageHeight: CGFloat { return offsetY + height }

    private init(view: UIView, text: String, type: GSMessageType, options: [GSMessageOption]?, inViewController: UIViewController?) {

        var view = view
        
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

        switch position {
        case .Top:
            if let inViewController = inViewController {
                let navigation = inViewController.navigationController ?? (inViewController as? UINavigationController)
                let navigationBarHidden = (navigation?.navigationBarHidden ?? true)
                let navigationBarTranslucent = (navigation?.navigationBar.translucent ?? false)
                let statusBarHidden = UIApplication.sharedApplication().statusBarHidden
                if !navigationBarHidden && navigationBarTranslucent && !statusBarHidden { offsetY+=20 }
                if !navigationBarHidden && navigationBarTranslucent { offsetY+=44; }
                if (navigationBarHidden && !statusBarHidden) { offsetY+=20 }
            }
        case .Bottom:
            y = view.bounds.size.height - height
        }

        if inViewController is UITableViewController {
            if let lastWindow = UIApplication.sharedApplication().windows.last {
                view = lastWindow as UIView
            }
        }

        message = UIView(frame: CGRect(x: 0, y: y, width: view.bounds.size.width, height: messageHeight))
        message.backgroundColor = backgroundColor

        messageText = UILabel(frame: CGRect(x: textPadding, y: offsetY, width: message.bounds.size.width - textPadding * 2, height: height))
        messageText.text = text
        messageText.font = GSMessage.font
        messageText.textColor = textColor
        messageText.textAlignment = textAlignment
        messageText.numberOfLines = textNumberOfLines
        message.addSubview(messageText)

        if hideOnTap { message.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(GSMessage.handleTap(_:)))) }

        self.view = view
    }

    @objc private func handleTap(tapGesture: UITapGestureRecognizer) {
        hide()
    }

    private func removeFromSuperview() {
        message.removeFromSuperview()
        view?.uninstallMessage = nil
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

private func GCDAfter(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}