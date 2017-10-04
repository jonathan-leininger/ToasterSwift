//
//  ToasterSwift.swift
//  ToasterSwift
//
//  Created by Jonathan LEININGER on 26/09/2017.
//

import Foundation
import UIKit

public class ToasterSwift: NSObject {

    // MARK:- Public properties
    
    public var textColor: UIColor = UIColor.white {
        didSet {
            if let view = self.view {
                view.textColor = self.textColor
            }
        }
    }

    public var backgroundColor: UIColor = UIColor(red: 78.0/255.0, green: 81.0/255.0, blue: 90.0/255.0, alpha: 1.0) {
        didSet {
            if let view = self.view {
                view.backgroundColor = self.backgroundColor
            }
        }
    }
    
    public var buttonCloseTitle: String = "Close"  {
        didSet {
            if let buttonClose = self.buttonClose {
                buttonClose.setTitle(self.buttonCloseTitle, for: UIControlState.normal)
            }
        }
    }
    
    // MARK:- Private properties
    
    private var buttonClose: UIButton?
    private var window: UIWindow?
    private var view: UILabel?
    private var timer: Timer?
    
    private let timeout: Int = 3
    private let marginBottom: CGFloat = 10.0
    private let marginLeft: CGFloat = 10.0
    private let marginRight: CGFloat = 10.0
    
    private let topInset = CGFloat(20)
    private let bottomInset = CGFloat(20)
    private let leftInset = CGFloat(20)
    private let rightInset = CGFloat(20)
    
    // MARK:- Public methods
    
    public class var shared: ToasterSwift {
        struct Static {
            static let instance: ToasterSwift = ToasterSwift()
        }
        return Static.instance
    }
    
    public func show(message: String, keep: Bool = false, close: Bool = false) -> Void {
        
        if let timer = self.timer {
            timer.invalidate()
        }
        
        guard let view = self.view else {
            print("Error view is nil")
            return
        }
        
        guard let window = self.window else {
            print("Error window is nil")
            return
        }
        
        if self.buttonClose == nil {
            self.setupButtonClose()
        }
        
        view.text = message
        
        if !close {
            if let buttonClose = self.buttonClose {
                buttonClose.removeFromSuperview()
            }
        }
        
        if !keep {
            self.timer = Timer.scheduledTimer(
                timeInterval: TimeInterval(self.timeout),
                target: self,
                selector: #selector(ToasterSwift.hide(_:)),
                userInfo: nil,
                repeats: false)
        } else {
            if let buttonClose = self.buttonClose {
                window.addSubview(buttonClose)
            }
        }
        
        self.setTextFrame(withButtonClose: close)
        
        window.addSubview(view)
    }
    
    public func hide() -> Void {
        self.hide(nil)
    }
    
    // MARK:- Private methods
    
    private override init() {
        super.init()
        if let window = UIApplication.shared.delegate?.window {
            self.window = window
            self.setupView()
        } else {
            print("Error window is nil")
        }
    }
    
    private func setupView() -> Void {
        self.view = InsetLabel()
        if let view = self.view {
            view.backgroundColor = self.backgroundColor
            view.textColor = UIColor.white
            view.layer.cornerRadius = 2
            view.numberOfLines = 0
        }
    }
    
    private class InsetLabel: UILabel {
        
        let topInset = CGFloat(20)
        let bottomInset = CGFloat(20)
        let leftInset = CGFloat(20)
        let rightInset = CGFloat(20)
        
        override func drawText(in rect: CGRect) {
            let insets: UIEdgeInsets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
            super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
        }
        
        override public var intrinsicContentSize: CGSize {
            var intrinsicSuperViewContentSize = super.intrinsicContentSize
            intrinsicSuperViewContentSize.height += topInset + bottomInset
            intrinsicSuperViewContentSize.width += leftInset + rightInset
            return intrinsicSuperViewContentSize
        }
    }
    
    private func setTextFrame(withButtonClose: Bool) {
        
        guard let view = self.view else {
            print("Error view is nil")
            return
        }
        
        let screenSize: CGRect = UIScreen.main.bounds
        let width: CGFloat = screenSize.width - marginLeft - marginRight
        
        if let text = view.text {
            let height: CGFloat = text.height(withConstrainedWidth: width - leftInset - rightInset, font: view.font) + topInset + bottomInset
            
            let x: CGFloat = marginLeft
            var y: CGFloat = screenSize.height - marginBottom - height
            if withButtonClose {
                if let buttonClose = self.buttonClose {
                    y -= buttonClose.frame.height
                }
            }
            view.frame = CGRect(x: x, y: y, width: width, height: height)
        } else {
            print("Warning : no text")
        }
    }
    
    private func setupButtonClose() -> Void {
        
        self.buttonClose = UIButton()
        
        if let buttonClose = self.buttonClose {
            buttonClose.setTitle(self.buttonCloseTitle, for: UIControlState.normal)
            buttonClose.addTarget(self, action: #selector(self.buttonClosePressed), for: .touchUpInside)
            let screenSize: CGRect = UIScreen.main.bounds
            buttonClose.frame = CGRect(
                x: self.marginLeft,
                y: screenSize.height - self.marginBottom - buttonClose.frame.size.height - topInset - bottomInset,
                width: screenSize.width - self.marginLeft - self.marginRight,
                height: buttonClose.frame.size.height + topInset + bottomInset)
            buttonClose.setTitleColor(UIColor.white, for: UIControlState.normal)
            buttonClose.backgroundColor = self.backgroundColor
        }
    }
    
    // MARK:- Actions
    
    func buttonClosePressed(sender: UIButton) {
        self.hide(nil)
    }
    
    func hide(_ timer: Timer?) {
        
        if let view = self.view {
            view.removeFromSuperview()
        }
        
        if let buttonClose = self.buttonClose {
            buttonClose.removeFromSuperview()
        }
    }
}
