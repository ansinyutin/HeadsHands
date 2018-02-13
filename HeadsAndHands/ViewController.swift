//
//  ViewController.swift
//  HeadsAndHands
//
//  Created by Синютин Андрей on 13.02.18.
//  Copyright © 2018 sinyutin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let btn = UIButton(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupLayout()
        setupEvents()
    }
    
    func setupViews() {        
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Авторизация", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
    }
    
    func setupLayout() {
        
        view.addSubview(btn)
        
        //Horizontal layout
        view.addConstraint(NSLayoutConstraint(item: btn,
                                              attribute: .centerX,
                                              relatedBy: .equal,
                                              toItem: btn.superview,
                                              attribute: .centerX,
                                              multiplier: 1.0,
                                              constant: 0))
        
        //Vertical layout
        view.addConstraint(NSLayoutConstraint(item: btn,
                                              attribute: .centerY,
                                              relatedBy: .equal,
                                              toItem: btn.superview,
                                              attribute: .centerY,
                                              multiplier: 1.0,
                                              constant: 0))
    }
    
    func setupEvents() {
        btn.addTarget(self, action: #selector(ViewController.onTapBtn), for: .touchUpInside)
    }
    
    @objc func onTapBtn() {
        showLoginVC()
    }
    
    func showLoginVC() {
        let loginVC = LoginVC()
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

