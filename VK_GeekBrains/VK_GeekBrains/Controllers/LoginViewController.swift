//
//  LoginViewController.swift
//  VK_GeekBrains
//
//  Created by Станислав on 30.03.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var scrollBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var loginTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWasShown(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillBeHidden(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
        
    }
    
    @objc func keyboardWasShown(notification: Notification) {
    let userInfo = (notification as NSNotification).userInfo as! [String: Any]
    let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
    
    scrollBottomConstraint.constant = frame.height
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
    scrollBottomConstraint.constant = 0
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        switch identifier {
        case "loginSegue":
            return login()
        default:
            return true
        }
    }
    
    func login() -> Bool {
        let login = loginTextField.text!
        let password = passwordTextField.text!
        
        if login == "" && password == "" {
            return true
        } else {
            showErrorAlert()
        }
        return false
    }
    
    func showErrorAlert() {
        let alert = UIAlertController(title: "Ошибка", message: "Не верный пароль или логин", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true){
            self.loginTextField.text = nil
            self.passwordTextField.text = nil
        }
    }
}
