//
//  BaseVC.swift
//  HeadsAndHands
//
//  Created by Синютин Андрей on 13.02.18.
//  Copyright © 2018 sinyutin. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {
    
    func setupKeyboardVisibilityNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(BaseVC.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(BaseVC.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
        guard let kbSizeValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue else { return }
        guard let kbDurationNumber = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber else { return }
        
        let keyboardHeight = kbSizeValue.cgRectValue.height
        
        animateToKeyboardHeight(keyboardHeight, duration: kbDurationNumber.doubleValue)
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        
        guard let kbDurationNumber = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber else { return }
        
        self.animateToKeyboardHeight(0, duration: kbDurationNumber.doubleValue)
    }
    
    func animateToKeyboardHeight(_ kbHeight: CGFloat, duration: Double) {
        
    }
}
