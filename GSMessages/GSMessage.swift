//
//  GSMessage.swift
//  GSMessages
//
//  Created by Gesen on 15/7/10.
//  Copyright (c) 2015年 Gesen. All rights reserved.
//

import UIKit

public enum GSMessageType {
    case success
    case error
    case warning
    case info
}

public enum GSMessagePosition {
    case top
    case bottom
}

public enum GSMessageAnimation {
    case slide
    case fade
}

public enum GSMessageTextAlignment {
    case topLeft
    case topCenter
    case topRight
    case left
    case center
    case right
    case bottomLeft
    case bottomCenter
    case bottomRight
}

public enum GSMessageOption {
    case animation(GSMessageAnimation)
    case animationDuration(TimeInterval)
    case autoHide(Bool)
    case autoHideDelay(Double) // Second
    case cornerRadius(Double)
    case height(Double)
    case hideOnTap(Bool)
    case handleTap(()->())
    case margin(UIEdgeInsets)
    case padding(UIEdgeInsets)
    case position(GSMessagePosition)
    case textAlignment(GSMessageTextAlignment)
    case textColor(UIColor)
    case textNumberOfLines(Int)
}

extension UIViewController {
    
    open func showMessage(_ text: String,
                          type: GSMessageType,
                          options: [GSMessageOption]? = nil) {
        
        GSMessage.showMessageAddedTo(text: text, type: type, options: options, inView: view, inViewController: self)
    }

    open func showMessage(_ attributedText: NSAttributedString,
                          type: GSMessageType,
                          options: [GSMessageOption]? = nil) {
        
        GSMessage.showMessageAddedTo(attributedText: attributedText, type: type, options: options, inView: view, inViewController: self)
    }

    open func hideMessage(animated: Bool = true) {
        view.hideMessage(animated: animated)
    }

}

extension UIView {
    
    open func showMessage(_ text: String,
                          type: GSMessageType,
                          options: [GSMessageOption]? = nil) {
        
        GSMessage.showMessageAddedTo(text: text, type: type, options: options, inView: self, inViewController: nil)
    }

    open func showMessage(_ attributedText: NSAttributedString,
                          type: GSMessageType,
                          options: [GSMessageOption]? = nil) {
        
        GSMessage.showMessageAddedTo(attributedText: attributedText, type: type, options: options, inView: self, inViewController: nil)
    }

    open func hideMessage(animated: Bool = true) {
        installedMessage?.hide(animated: animated)
    }

}

public class GSMessage: NSObject {

    public static var font : UIFont = UIFont.systemFont(ofSize: 14)
    
    public static var successBackgroundColor : UIColor = UIColor(red: 142.0/255, green: 183.0/255, blue: 64.0/255,  alpha: 0.95)
    public static var warningBackgroundColor : UIColor = UIColor(red: 230.0/255, green: 189.0/255, blue: 1.0/255,   alpha: 0.95)
    public static var errorBackgroundColor   : UIColor = UIColor(red: 219.0/255, green: 36.0/255,  blue: 27.0/255,  alpha: 0.70)
    public static var infoBackgroundColor    : UIColor = UIColor(red: 44.0/255,  green: 187.0/255, blue: 255.0/255, alpha: 0.90)
    
    public class func showMessageAddedTo(text: String,
                                         type: GSMessageType,
                                         options: [GSMessageOption]?,
                                         inView: UIView,
                                         inViewController: UIViewController?) {
        
        let attributedText = NSAttributedString(
            string: text,
            attributes: [
                .font: GSMessage.font,
                .foregroundColor: UIColor.white,
                .paragraphStyle: NSParagraphStyle()
            ]
        )
        
        showMessageAddedTo(attributedText: attributedText, type: type, options: options, inView: inView, inViewController: inViewController)
    }

    public class func showMessageAddedTo(attributedText: NSAttributedString,
                                         type: GSMessageType,
                                         options: [GSMessageOption]?,
                                         inView: UIView,
                                         inViewController: UIViewController?) {
        
        if inView.installedMessage != nil && inView.uninstallMessage == nil {
            inView.hideMessage()
        }
        
        if inView.installedMessage == nil {
            GSMessage(attributedText: attributedText,
                      type: type,
                      options: options,
                      inView: inView,
                      inViewController: inViewController).show()
        }
    }

    public func show() {

        guard inView?.installedMessage == nil else {
            return
        }

        inView?.installedMessage = self
        inView?.addSubview(containerView)
        
        updateFrames()

        if animation == .fade {
            
            messageView.alpha = 0
            
            UIView.animate(withDuration: animationDuration,
                           animations: { self.messageView.alpha = 1 })
        }

        else if animation == .slide && position == .top {
            
            messageView.transform = CGAffineTransform(
                translationX: 0,
                y: -messageHeight + -margin.top
            )
            
            UIView.animate(
                withDuration: animationDuration,
                animations: {
                    self.messageView.transform = CGAffineTransform(
                        translationX: 0,
                        y: 0
                    )
                }
            )
        }

        else if animation == .slide && position == .bottom {
            
            messageView.transform = CGAffineTransform(
                translationX: 0,
                y: height + margin.bottom
            )
            
            UIView.animate(
                withDuration: animationDuration,
                animations: {
                    self.messageView.transform = CGAffineTransform(
                        translationX: 0,
                        y: 0
                    )
                }
            )
        }

        if autoHide {
            GS_GCDAfter(autoHideDelay) { [weak self] in
                self?.hide(animated: true)
            }
        }
    }

    public func hide(animated: Bool) {
        
        guard
            inView.installedMessage === self &&
            inView?.uninstallMessage == nil else {
            return
        }

        inView?.uninstallMessage = self
        inView?.installedMessage = nil
        
        guard animated else {
            removeFromSuperview()
            return
        }

        if animation == .fade {
            
            UIView.animate(
                withDuration: self.animationDuration,
                animations: { self.messageView.alpha = 0 },
                completion: { _ in self.removeFromSuperview() }
            )
        }

        else if animation == .slide && position == .top {
            
            UIView.animate(
                withDuration: self.animationDuration,
                animations: {
                    self.messageView.transform = CGAffineTransform(
                        translationX: 0,
                        y: -self.messageHeight + -self.margin.top
                    )
                },
                completion: { _ in self.removeFromSuperview() }
            )
        }

        else if animation == .slide && position == .bottom {
            
            UIView.animate(
                withDuration: self.animationDuration,
                animations: {
                    self.messageView.transform = CGAffineTransform(
                        translationX: 0,
                        y: self.messageHeight + self.margin.bottom
                    )
                },
                completion: { _ in self.removeFromSuperview() }
            )
        }

    }

    public private(set) weak var inView: UIView!
    public private(set) weak var inViewController: UIViewController?
    
    public private(set) var containerView = UIView()
    public private(set) var messageView = UIView()
    public private(set) var messageText = UILabel()
    
    public private(set) var animation: GSMessageAnimation = .slide
    public private(set) var animationDuration: TimeInterval = 0.3
    public private(set) var autoHide: Bool = true
    public private(set) var autoHideDelay: Double = 3
    public private(set) var cornerRadius: CGFloat = 0
    public private(set) var height: CGFloat = 44
    public private(set) var hideOnTap: Bool = true
    public private(set) var handleTap:  (() -> ())?
    public private(set) var margin: UIEdgeInsets = .zero
    public private(set) var padding: UIEdgeInsets = .init(top: 10, left: 30, bottom: 10, right: 30)
    public private(set) var position: GSMessagePosition = .top
    public private(set) var textAlignment: GSMessageTextAlignment = .center
    public private(set) var textColor: UIColor = .white
    public private(set) var textNumberOfLines: Int = 1
    
    public var messageWidth:  CGFloat {
        return inView.frame.width - margin.horizontal
    }
    public var messageHeight: CGFloat {
        return abs(offsetY) + height
    }
    
    fileprivate var y: CGFloat = 0
    fileprivate var offsetY: CGFloat = 0
    fileprivate var observingTableVC: UITableViewController?
    
    fileprivate var textWidth: CGFloat {
        return messageWidth - padding.horizontal
    }

    public init(attributedText: NSAttributedString,
                type: GSMessageType,
                options: [GSMessageOption]?,
                inView: UIView, 
                inViewController: UIViewController?) {

        for option in options ?? [] {
            switch (option) {
            case let .animation(value): animation = value
            case let .animationDuration(value): animationDuration = value
            case let .autoHide(value): autoHide = value
            case let .autoHideDelay(value): autoHideDelay = value
            case let .cornerRadius(value): cornerRadius = CGFloat(value)
            case let .height(value): height = CGFloat(value)
            case let .hideOnTap(value): hideOnTap = value
            case let .handleTap(value): handleTap = value
            case let .margin(value): margin = value
            case let .padding(value): padding = value
            case let .position(value): position = value
            case let .textAlignment(value): textAlignment = value
            case let .textColor(value): textColor = value
            case let .textNumberOfLines(value): textNumberOfLines = value
            }
        }
        
        super.init()

        if let vc = inViewController as? UITableViewController {
            observingTableVC = vc
            vc.tableView.addObserver(self, forKeyPath: "contentOffset", options: [.new], context: &observerContext)
        }

        switch type {
        case .success:
            messageView.backgroundColor = GSMessage.successBackgroundColor
        case .warning:
            messageView.backgroundColor = GSMessage.warningBackgroundColor
        case .error:
            messageView.backgroundColor = GSMessage.errorBackgroundColor
        case .info:
            messageView.backgroundColor = GSMessage.infoBackgroundColor
        }
        
        containerView.layer.zPosition = 1
        containerView.addSubview(messageView)

        messageText.attributedText = attributedText
        messageText.numberOfLines = textNumberOfLines
        messageText.textColor = textColor
        messageText.textAlignment = textAlignment.nsTextAlignment
        messageView.addSubview(messageText)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateFrames), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        if position == .top {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        }
        
        if hideOnTap { messageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapForHide(_:)))) }
        
        if handleTap != nil {
            messageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(_:))))
        }

        self.inView = inView
        self.inViewController = inViewController
    }
    
    deinit {
        if let tvc = observingTableVC {
            tvc.tableView.removeObserver(self, forKeyPath: "contentOffset")
            observingTableVC = nil
        }
        NotificationCenter.default.removeObserver(self)
    }

    @objc fileprivate func handleTapForHide(_ tapGesture: UITapGestureRecognizer) {
        hide(animated: true)
    }
    
    @objc fileprivate func handleTap(_ tapGesture: UITapGestureRecognizer) {
        if let handleTap = handleTap {
            handleTap()
        }
    }
    
    @objc fileprivate func updateFrames() {
        guard inView != nil else { return }
        y       = 0
        offsetY = 0
        
        
        var textSize: CGSize = .zero
        
        if let attrText = messageText.attributedText {
            let size = CGSize(width: textWidth / 2, height: 999)
            let framesetter = CTFramesetterCreateWithAttributedString(attrText)
            textSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRange(), nil, size, nil)
        }
        
        if textNumberOfLines == 0 {
            height = max(ceil(textSize.height) + padding.vertical, height)
        }
        
        calculatePosition()
        
        updateMessageFrame()
        updateCornerRadius()
        updateMessageTextSize(textSize: textSize)
    }
    
    func calculatePosition() {
        
        switch position {
            
        case .top:
            y = max(0 - inView.frame.origin.y, 0)
            
            if let vc = inViewController {
                
                offsetY += margin.top
                
                if #available(iOS 11.0, *) {
                    offsetY += vc.view.safeAreaInsets.top
                    break
                }
                
                if vc.edgesForExtendedLayout == [] {
                    break
                }
                
                let statusBarHeight = UIApplication.shared.statusBarFrame.height
                let nav = vc.navigationController ?? (vc as? UINavigationController)
                let isNavBarHidden = nav?.isNavigationBarHidden ?? true
                let isNavBarTranslucent = nav?.navigationBar.isTranslucent ?? false
                let navBarHeight = nav?.navigationBar.frame.size.height ?? 44
                let isStatusBarHidden = UIApplication.shared.isStatusBarHidden
                if !isNavBarHidden && isNavBarTranslucent && !isStatusBarHidden { offsetY += statusBarHeight }
                if !isNavBarHidden && isNavBarTranslucent { offsetY += navBarHeight }
                if (isNavBarHidden && !isStatusBarHidden) { offsetY += statusBarHeight }
            } else {
                y += margin.top
            }
            
        case .bottom:
            y = inView.bounds.size.height - height
            
            if let vc = inViewController {
                offsetY -= margin.top
                
                if #available(iOS 11.0, *) {
                    offsetY -= vc.view.safeAreaInsets.bottom
                    y = inView.bounds.size.height - height + offsetY
                }
            } else {
                y -= margin.bottom
            }
        }
    }
    
    func updateMessageFrame() {
        
        containerView.frame = CGRect(
            x: margin.left,
            y: y + (observingTableVC?.tableView.contentOffset.y ?? 0),
            width: messageWidth,
            height: messageHeight
        )
        
        messageView.frame = containerView.bounds
    }
    
    func updateCornerRadius() {
        
        guard cornerRadius > 0 else { return }
            
        let corners: UIRectCorner
        
        if inViewController == nil {
            corners = [.topLeft, .topRight, .bottomLeft, .bottomRight]
        } else {
            switch position {
            case .top:      corners = [.bottomLeft, .bottomRight]
            case .bottom:   corners = [.topLeft, .topRight]
            }
        }
        
        let cornerLayer = CAShapeLayer()
        
        cornerLayer.path = UIBezierPath(
            roundedRect:containerView.bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
        ).cgPath
        
        messageView.layer.mask = cornerLayer
    }
    
    func updateMessageTextSize(textSize: CGSize) {
        
        var textY = max(0, offsetY) + padding.top
        var textHeight = textSize.height
        let textMaxHeight = height - padding.vertical
        
        if textHeight > textMaxHeight {
            textHeight = textMaxHeight
        } else {
            switch textAlignment {
            case .topLeft, .topCenter, .topRight:
                break
            case .left, .center, .right:
                textY += (textMaxHeight - textHeight) / 2
            case .bottomLeft, .bottomCenter, .bottomRight:
                textY += textMaxHeight - textHeight
            }
        }
        
        messageText.frame = CGRect(
            x: padding.left,
            y: textY,
            width: textWidth,
            height: textHeight
        )
    }
    
    func removeFromSuperview() {
        containerView.removeFromSuperview()
        inView?.uninstallMessage = nil
    }

}

@objc fileprivate extension GSMessage {
    
    func keyboardWillShow(notification: NSNotification) {
        guard let inView = self.inView else { return }
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.messageView.frame.origin.y == 0 && inView.frame.origin.y < 0 {
                self.messageView.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.messageView.frame.origin.y != 0 {
                self.messageView.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
}

extension GSMessage {
    
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard context == &observerContext else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }
        
        guard keyPath == "contentOffset",
              let contentOffset = (change?[.newKey] as? NSValue)?.cgPointValue
              else { return }

        containerView.frame.origin.y = y + contentOffset.y
    }
    
}

fileprivate extension UIView {

    var installedMessage: GSMessage? {
        get { return objc_getAssociatedObject(self, &installedMessageKey) as? GSMessage }
        set { objc_setAssociatedObject(self, &installedMessageKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    var uninstallMessage: GSMessage? {
        get { return objc_getAssociatedObject(self, &uninstallMessageKey) as? GSMessage }
        set { objc_setAssociatedObject(self, &uninstallMessageKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

}

fileprivate extension GSMessageTextAlignment {

    var nsTextAlignment: NSTextAlignment {
        switch self {
        case .left, .topLeft, .bottomLeft:          return .left
        case .center, .topCenter, .bottomCenter:    return .center
        case .right, .topRight, .bottomRight:       return .right
        }
    }
    
}

fileprivate extension UIEdgeInsets {
    var horizontal: CGFloat { return left + right }
    var vertical:   CGFloat { return top + bottom }
}

private var installedMessageKey = ""
private var uninstallMessageKey = ""
private var observerContext = ""

private func GS_GCDAfter(_ delay:Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}
