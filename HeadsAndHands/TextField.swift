//
//  TextField.swift
//  HeadsAndHands
//
//  Created by Синютин Андрей on 13.02.18.
//  Copyright © 2018 sinyutin. All rights reserved.
//

import UIKit

class TextField: UITextField {
    
    var fieldTitle = ""
    
    var borderColor = UIColor.gray {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 0, y: 10, width: bounds.width, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 0, y: 10, width: bounds.width, height: bounds.height)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 50, y: 0, width: bounds.width, height: 20)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let rectanglePath = UIBezierPath(rect: CGRect(x: 0, y: rect.size.height - 1, width: rect.size.width, height: 1))
        borderColor.setFill()
        rectanglePath.fill()
        
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Text Drawing
        let textRect = CGRect(x: 0, y: 0, width: rect.width, height: 20)
        let textTextContent = fieldTitle
        let textStyle = NSMutableParagraphStyle()
        textStyle.alignment = .left
        let textFontAttributes:[NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font: UIFont(name: ".SFUIText-Regular", size: 13)!,
            NSAttributedStringKey.kern: 0.1,
            NSAttributedStringKey.foregroundColor: UIColor.init(rgba: "#333333"),
            NSAttributedStringKey.paragraphStyle: textStyle
        ]
        
        let textTextHeight: CGFloat = textTextContent.boundingRect(with: CGSize(width: textRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: textFontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: textRect)
        textTextContent.draw(in: CGRect(x: textRect.minX, y: textRect.minY + (textRect.height - textTextHeight) / 2, width: textRect.width, height: textTextHeight), withAttributes: textFontAttributes)
        context.restoreGState()
    }
    
    //Bounce bugfix
    override func resignFirstResponder() -> Bool {
        let result = super.resignFirstResponder()
        layoutIfNeeded()
        return result
    }
}
