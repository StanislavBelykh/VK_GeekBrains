//
//  LoadingViewController.swift
//  VK_GeekBrains
//
//  Created by Станислав on 15.04.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    
    @IBOutlet weak var leftDot: UIView!
    
    @IBOutlet weak var middleDot: UIView!
    
    @IBOutlet weak var rightDot: UIView!
    
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leftDot.layer.cornerRadius = leftDot.bounds.height/2
        middleDot.layer.cornerRadius = middleDot.bounds.height/2
        rightDot.layer.cornerRadius = rightDot.bounds.height/2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animation()
    }
    func animation(){
        
        UIView.animate(withDuration: 1, animations: {
            self.leftDot.alpha = 0
        }) { _ in
            self.leftDot.alpha = 1
            UIView.animate(withDuration: 1, animations: {
                self.middleDot.alpha = 0
            }) { _ in
                self.middleDot.alpha = 1
                UIView.animate(withDuration: 1, animations: {
                    self.rightDot.alpha = 0
                }) { _ in
                    self.rightDot.alpha = 1
                    if self.counter < 1 {
                        self.counter += 1
                        self.animation()
                    } else {
                       let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                        let loginViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                        loginViewController.modalPresentationStyle = .fullScreen
                        self.present(loginViewController, animated: true, completion: nil)
                    }
                }
            }
        }
    }
}
