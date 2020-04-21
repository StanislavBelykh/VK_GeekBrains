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
        pathAnimation()
    }
    func animation(){
        UIView.animateKeyframes(
            withDuration: 2,
            delay: 0,
            options: [],
            animations: {
                UIView.addKeyframe(
                    withRelativeStartTime: 0,
                    relativeDuration: 1/3) {
                        self.leftDot.alpha = 0
                }
                UIView.addKeyframe(
                    withRelativeStartTime: 1/3,
                    relativeDuration: 1/3) {
                        self.leftDot.alpha = 1
                        self.middleDot.alpha = 0
                }
                UIView.addKeyframe(
                    withRelativeStartTime: 2/3,
                    relativeDuration: 1/3) {
                        self.middleDot.alpha = 1
                        self.rightDot.alpha = 0
                }
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
    func pathAnimation(){
        
        let cloudView = UIView()
        
        view.addSubview(cloudView)
        cloudView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cloudView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cloudView.bottomAnchor.constraint(equalTo: middleDot.topAnchor, constant: -10),
            cloudView.widthAnchor.constraint(equalToConstant: 120),
            cloudView.heightAnchor.constraint(equalToConstant: 70)
        ])
    
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 10, y: 60))
        path.addQuadCurve(to: CGPoint(x: 20, y: 40), controlPoint: CGPoint(x: 5, y: 50))
        path.addQuadCurve(to: CGPoint(x: 40, y: 20), controlPoint: CGPoint(x: 20, y: 20))
        path.addQuadCurve(to: CGPoint(x: 70, y: 20), controlPoint: CGPoint(x: 55, y: 0))
        path.addQuadCurve(to: CGPoint(x: 80, y: 30), controlPoint: CGPoint(x: 80, y: 20))
        path.addQuadCurve(to: CGPoint(x: 110, y: 60), controlPoint: CGPoint(x: 110, y: 30))
        path.close()

        
        let layerAnimation = CAShapeLayer()
        layerAnimation.path = path.cgPath
        layerAnimation.strokeColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        layerAnimation.fillColor = UIColor.clear.cgColor
        layerAnimation.lineWidth = 8
        layerAnimation.lineCap = .round

        cloudView.layer.addSublayer(layerAnimation)
        
        let pathAnimationEnd = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimationEnd.fromValue = 0
        pathAnimationEnd.toValue = 1
        pathAnimationEnd.duration = 2
        pathAnimationEnd.fillMode = .both
        pathAnimationEnd.isRemovedOnCompletion = false
        layerAnimation.add(pathAnimationEnd, forKey: nil)
        
        let pathAnimationStart = CABasicAnimation(keyPath: "strokeStart")
        pathAnimationStart.fromValue = 0
        pathAnimationStart.toValue = 1
        pathAnimationStart.duration = 2
        pathAnimationStart.fillMode = .both
        pathAnimationStart.isRemovedOnCompletion = false
        pathAnimationStart.beginTime = 1
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 3
        animationGroup.fillMode = CAMediaTimingFillMode.backwards
        animationGroup.animations = [pathAnimationEnd, pathAnimationStart]
        animationGroup.repeatCount = .infinity
        layerAnimation.add(animationGroup, forKey: nil)

    }
    
}
