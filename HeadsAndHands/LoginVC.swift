//
//  LoginVC.swift
//  HeadsAndHands
//
//  Created by Синютин Андрей on 13.02.18.
//  Copyright © 2018 sinyutin. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire

class LoginVC: BaseVC {
    
    var loginField = TextField(frame: .zero)
    var passField = TextField(frame: .zero)
    
    var signInBtn = UIButton(frame: .zero)
    var forgotPassBtn = UIButton(frame: .zero)
    var registerBtn = UIButton(frame: .zero)
    
    var contentView = UIView(frame: .zero)
    
    var password = ""
    
    var contentVCenterConst = NSLayoutConstraint()
    var contentVBottomConst = NSLayoutConstraint()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupLayout()
        setupEvents()
        
        validate()
    }
    
    func setupViews() {
        
        title = "Авторизация"
        navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.backItem?.title = ""
        
        view.backgroundColor = UIColor.white
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
//        contentView.backgroundColor = .lightGray
        
        loginField.fieldTitle = "Почта"
        loginField.translatesAutoresizingMaskIntoConstraints = false
        loginField.isEnabled = true
        loginField.autocapitalizationType = .none
        loginField.clearButtonMode = UITextFieldViewMode.whileEditing
        loginField.font = UIFont(name: ".SFUIText-Regular", size: 16)!
        loginField.textColor = UIColor.init(rgba: "#333333")
        loginField.delegate = self
//        loginField.text = "test@test.ru"
        
        passField.fieldTitle = "Пароль"
        passField.translatesAutoresizingMaskIntoConstraints = false
//        passField.isSecureTextEntry = true
        passField.autocapitalizationType = .none
        passField.font = UIFont(name: ".SFUIText-Regular", size: 15)
        passField.delegate = self
        passField.textColor = UIColor.init(rgba: "#333333")
//        passField.text = "1j2J3123123123"
        
        signInBtn.translatesAutoresizingMaskIntoConstraints = false
        signInBtn.layer.cornerRadius = 23
        signInBtn.titleLabel?.font = UIFont(name: ".SFUIText-Medium", size: 15)
        signInBtn.setAttributedTitle("Войти".attributed(kern: -0.2, color: UIColor.white), for: .normal)
        signInBtn.backgroundColor = UIColor.init(rgba: "#ff9b00")
        
        registerBtn.translatesAutoresizingMaskIntoConstraints = false
        registerBtn.setTitleColor(UIColor.init(rgba: "#3785c8"), for: .normal)
        registerBtn.titleLabel?.font = UIFont(name: ".SFUIText-Regular", size: 15)
        registerBtn.setTitle("У меня еще нет аккаунта. Создать.", for: .normal)
        
        forgotPassBtn.translatesAutoresizingMaskIntoConstraints = false
        forgotPassBtn.setTitleColor(UIColor.init(rgba: "#797979"), for: .normal)
        forgotPassBtn.backgroundColor = .white
        forgotPassBtn.layer.borderColor = UIColor.init(rgba: "#ebebeb").cgColor
        forgotPassBtn.layer.borderWidth = 0.5
        forgotPassBtn.layer.cornerRadius = 4
        forgotPassBtn.titleLabel?.font = UIFont(name: ".SFUIText-Regular", size: 12)
        forgotPassBtn.setAttributedTitle("Забыли пароль?".attributed(kern: -0.1), for: .normal)
    }
    
    func setupLayout() {
        layoutCenterView()
        layoutForm()
    }
    
    func layoutCenterView() {
        
        view.addSubview(contentView)
        
        let metrics: [String: Any] = [:]
        let views: [String: UIView] = ["contentView": contentView]
        
        //Horizontal layout
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-<=15-[contentView]-<=16-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))

        //Vertical layout
        
        contentVBottomConst = NSLayoutConstraint(item: contentView,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: contentView.superview,
                           attribute: .bottom,
                           multiplier: 1.0,
                           constant: 0)
        
        view.addConstraint(contentVBottomConst)
        
        contentVCenterConst = NSLayoutConstraint(item: contentView,
                                                 attribute: .centerY,
                                                 relatedBy: .equal,
                                                 toItem: contentView.superview,
                                                 attribute: .centerY,
                                                 multiplier: 1.0,
                                                 constant: 0)
        view.addConstraint(contentVCenterConst)
        
        contentVBottomConst.isActive = false
        contentVCenterConst.isActive = true
    }
    
    func layoutForm() {
        
        contentView.addSubview(loginField)
        contentView.addSubview(passField)
        contentView.addSubview(signInBtn)
        contentView.addSubview(registerBtn)
        contentView.addSubview(forgotPassBtn)
        
        let forgotPassBottom:CGFloat = 9.0
        
        let metrics: [String: Any] = [
            "fieldHeight": 46.5,
            "fieldWidth": 300.0,
            "loginBottom": 10.5,
            "passBottom": 34.0,
            "signInBottom": 15.0,
            "signInHeight": 44.0,
            "signInWidth": 148.0,
            "registerBottom": 21.5,
            "forgotPassHeight": 30.0,
            "forgotPassWidth": 115.0
        ]
        
        let views: [String: UIView] = [
            "loginField": loginField,
            "passField": passField,
            "signInBtn": signInBtn,
            "registerBtn": registerBtn,
            "forgotPassBtn": forgotPassBtn,
        ]
        
        //Horizontal layout
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[loginField]|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[passField]|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "[forgotPassBtn(forgotPassWidth)]|",
                                                                  options: [],
                                                                  metrics: metrics,
                                                                  views: views))
        
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "[signInBtn(signInWidth)]",
                                                                  options: [],
                                                                  metrics: metrics,
                                                                  views: views))
        
        contentView.addConstraints([NSLayoutConstraint(item: signInBtn,
                                               attribute: .centerX,
                                               relatedBy: .equal,
                                               toItem: signInBtn.superview,
                                               attribute: .centerX,
                                               multiplier: 1.0,
                                               constant: 0)])

        contentView.addConstraints([NSLayoutConstraint(item: registerBtn,
                                                attribute: .centerX,
                                                relatedBy: .equal,
                                                toItem: registerBtn.superview,
                                                attribute: .centerX,
                                                multiplier: 1.0,
                                                constant: 0)])
        
        
        
        
        
        //Vertical layout
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|->=0-[loginField(fieldHeight)]-(loginBottom)-[passField(fieldHeight)]-(passBottom)-[signInBtn(signInHeight)]-(signInBottom)-[registerBtn]-(registerBottom)-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[forgotPassBtn(forgotPassHeight)]",
                                                                  options: [],
                                                                  metrics: metrics,
                                                                  views: views))
            
        contentView.addConstraints([NSLayoutConstraint(item: forgotPassBtn,
                                                       attribute: .bottom,
                                                       relatedBy: .equal,
                                                       toItem: passField,
                                                       attribute: .bottom,
                                                       multiplier: 1.0,
                                                       constant: -forgotPassBottom)])
    }
    
    //MARK: - Events
    
    func setupEvents() {
        loginField.addTarget(self, action: #selector(LoginVC.onChangeLogin), for: .editingChanged)
        passField.addTarget(self, action: #selector(LoginVC.onChangePassword), for: .editingChanged)
        signInBtn.addTarget(self, action: #selector(LoginVC.onSignInBtn), for: .touchUpInside)
        
        setupKeyboardVisibilityNotifications()
    }
    
    // MARK: - Event Handlers
    
    @objc func onChangeLogin(_ loginField:UITextField) {
        
        loginField.attributedText = loginField.text?.attributed(kern: -0.3)
        validate()
    }
    
    @objc func onChangePassword(_ passwordField:UITextField) {
        validate()
    }
    
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == loginField {
            passField.becomeFirstResponder()
        } else if textField == passField {
            if isValid() {
                login()
            }
            view.endEditing(true)
        }
        
        return false
    }
    
    @objc func onSignInBtn() {
        login()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    
    //MARK: - Validation
    
    func validate() {
        let valid = isValid()
        
        signInBtn.isEnabled = valid
        signInBtn.alpha = valid ? 1.0 : 0.7
    }
    
    func isValid() -> Bool {
        return isLoginValid() && isPasswordValid()
    }
    
    func isLoginValid() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: loginField.text)
    }
    
    func isPasswordValid() -> Bool {
        let passRegex = "(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{6,}"
        return NSPredicate(format: "SELF MATCHES %@", passRegex).evaluate(with: password)
    }
    
    
    //MARK: - Actions
    
    func showAlert(title: String, text: String) {
        let alertController = UIAlertController(title: title, message: text, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
            print("OK")
        })
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func popVC() {
        navigationController?.popViewController(animated: true)
    }
    
    func login() {
        
        print("Sign in with: \(String(describing: loginField.text)) - \(password)")
        
        let url = "http://samples.openweathermap.org/data/2.5/weather?id=2172797&appid=b6907d289e10d714a6e88b30761fae22"
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        Alamofire.request(url).responseJSON(completionHandler: { (response) in
            
            MBProgressHUD.hide(for: self.view, animated: true)
            
            if let json = response.result.value as? Dictionary<String, AnyObject>,
                let main = json["main"],
                let temp = main["temp"] as? Double,
                let humidity = main["humidity"]  as? Double,
                let pressure = main["pressure"] as? Double {

                let str = "Температура: \(String(describing: temp))\nДавление: \(String(describing: pressure))\nВлажность: \(String(describing: humidity))"

                self.showAlert(title: "Погода", text: str)
            }

            if let error = response.error {
                self.showAlert(title: "Ошибка", text: error.localizedDescription)
            }
        })
    }
    
    //MARK: - Keyboard Visibility
    
    override func animateToKeyboardHeight(_ kbHeight: CGFloat, duration: Double) {
        
        let expand = kbHeight > 0
        
        view.setNeedsUpdateConstraints()
        
        UIView.animate(withDuration: duration, animations: {
            self.contentVBottomConst.isActive = expand
            self.contentVCenterConst.isActive = !expand
            self.contentVBottomConst.constant = -kbHeight
            self.view.layoutIfNeeded()
        })
    }
}

extension LoginVC:UITextFieldDelegate {
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == passField {
            
            var hashPassword = String()
            let newChar = string.first
            let offsetToUpdate = password.index(password.startIndex, offsetBy: range.location)
            
            if string == "" {
                
                if ( offsetToUpdate.encodedOffset == 0 ) {
                    password = ""
                } else {
                    password.remove(at: offsetToUpdate)
                }
                
                return true
            }
            else { password.insert(newChar!, at: offsetToUpdate) }
            
            for _ in password {  hashPassword += "*" }
            textField.text = hashPassword
            validate()
            return false
        }

        return true
    }
}


