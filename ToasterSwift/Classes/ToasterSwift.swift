//
//  ToasterSwift.swift
//
//  Created by Jonathan Leininger on 29/08/2017.
import Foundation
import UIKit

public class ToasterSwift: NSObject {
    
    private let timeout: Int = 3
    private let marginBottom: CGFloat = 10.0
    private let marginLeft: CGFloat = 10.0
    private let marginRight: CGFloat = 10.0
    
    private let window = UIApplication.shared.delegate?.window!
    private var view: UILabel!
    private var buttonClose: UIButton!
    private var timer: Timer?
    
    private let topInset = CGFloat(20)
    private let bottomInset = CGFloat(20)
    private let leftInset = CGFloat(20)
    private let rightInset = CGFloat(20)
    
    private let backgroundColor: UIColor = UIColor(red: 78.0/255.0, green: 81.0/255.0, blue: 90.0/255.0, alpha: 1.0)
    
    // MARK:- Public
    
    public class var shared: ToasterSwift {
        struct Static {
            static let instance: ToasterSwift = ToasterSwift()
        }
        return Static.instance
    }
    
    public func show(message: String, keep: Bool, close: Bool) -> Void {
        
        if view == nil {
            self.setupText()
        }
        
        if self.buttonClose == nil {
            self.setupButtonClose()
        }
        
        if let timer = self.timer {
            timer.invalidate()
        }
        
        view.text = message
        
        if !close {
            self.buttonClose.removeFromSuperview()
        }
        
        if !keep {
            self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(self.timeout), target: self, selector: #selector(ToasterSwift.hide(_:)), userInfo: nil, repeats: false)
        } else {
            self.window?.addSubview(self.buttonClose)
        }
        
        self.setTextFrame(withButtonClose: close)
        
        self.window?.addSubview(view)
    }
    
    public func hide() -> Void {
        self.hide(nil)
    }
    
    // MARK:- Private
    
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
        let screenSize: CGRect = UIScreen.main.bounds
        
        let width: CGFloat = screenSize.width - marginLeft - marginRight
        if let text = self.view.text {
            let height: CGFloat = text.height(withConstrainedWidth: width - leftInset - rightInset, font: view.font) + topInset + bottomInset
            
            let x: CGFloat = marginLeft
            var y: CGFloat = screenSize.height - marginBottom - height
            if withButtonClose {
                y -= self.buttonClose.frame.height
            }
            view.frame = CGRect(x: x, y: y, width: width, height: height)
        } else {
            print("Warning : no text")
        }
    }
    
    private func setupButtonClose() -> Void {
        self.buttonClose = UIButton()
        self.buttonClose.setTitle("Close", for: UIControlState.normal)
        self.buttonClose.addTarget(self, action: #selector(self.buttonClosePressed), for: .touchUpInside)
        let screenSize: CGRect = UIScreen.main.bounds
        self.buttonClose.frame = CGRect(x: self.marginLeft,
                                        y: screenSize.height - self.marginBottom - self.buttonClose.frame.size.height - topInset - bottomInset,
                                        width: screenSize.width - self.marginLeft - self.marginRight,
                                        height: self.buttonClose.frame.size.height + topInset + bottomInset)
        self.buttonClose.setTitleColor(UIColor.white, for: UIControlState.normal)
        self.buttonClose.backgroundColor = self.backgroundColor
        
    }
    
    private func setupText() {
        view = InsetLabel()
        view.backgroundColor = self.backgroundColor
        view.textColor = UIColor.white
        view.layer.cornerRadius = 2
        view.numberOfLines = 0
    }
    
    func buttonClosePressed(sender: UIButton!) {
        self.hide(nil)
    }
    
    func hide(_ timer: Timer?) {
        view.removeFromSuperview()
        self.buttonClose.removeFromSuperview()
    }
    
}
