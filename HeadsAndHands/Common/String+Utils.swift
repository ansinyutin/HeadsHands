//
//  String+Utils.swift
//  HeadsAndHands
//
//  Created by Синютин Андрей on 13.02.18.
//  Copyright © 2018 sinyutin. All rights reserved.
//

import UIKit

extension String {
    func attributed(kern: Float, color:UIColor? = nil, font: UIFont? = nil) -> NSAttributedString {
        let attributed = NSMutableAttributedString(string: self)
        attributed.addAttribute(NSAttributedStringKey.kern, value: kern, range: NSMakeRange(0, attributed.length))
        
        if let textColor = color {
            attributed.addAttribute(NSAttributedStringKey.foregroundColor, value: textColor, range: NSMakeRange(0, attributed.length))
        }
        
        if let textFont = font {
            attributed.addAttribute(NSAttributedStringKey.font, value: textFont, range: NSMakeRange(0, attributed.length))
        }
        
        return attributed
    }
}

