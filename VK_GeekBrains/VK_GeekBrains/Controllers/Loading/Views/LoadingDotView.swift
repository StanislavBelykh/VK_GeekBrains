//
//  LoadingDotView.swift
//  VK_GeekBrains
//
//  Created by Станислав on 15.04.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import UIKit

class LoadingDotView: UIView {
    
    let leftDote: UIView = {
        let leftDote = UIView()
        leftDote.layer.cornerRadius = leftDote.bounds.height/2
        leftDote.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        leftDote.translatesAutoresizingMaskIntoConstraints = false
        return leftDote
    }()
    let centrDote: UIView  = {
        let centrDote = UIView()
        centrDote.layer.cornerRadius = centrDote.bounds.height/2
        centrDote.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        centrDote.translatesAutoresizingMaskIntoConstraints = false
        return centrDote
    }()
    let rightDote: UIView  = {
        let rightDote = UIView()
        rightDote.layer.cornerRadius = rightDote.bounds.height/2
        rightDote.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        rightDote.translatesAutoresizingMaskIntoConstraints = false
        return rightDote
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        UIView.animate(withDuration: 1, delay: 0, options: [.repeat], animations: {
            self.leftDote.alpha = 0
        }) { _ in
            self.leftDote.alpha = 1
            UIView.animate(withDuration: 1, animations: {
                self.centrDote.alpha = 0
            }) { _ in
                self.centrDote.alpha = 1
                UIView.animate(withDuration: 1, animations: {
                    self.rightDote.alpha = 0
                }) { _ in
                    self.rightDote.alpha = 1
                }
            }
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override class func awakeFromNib() {

    }
    override func layoutSubviews() {
        NSLayoutConstraint.activate([
            leftDote.topAnchor.constraint(equalTo: topAnchor),
            leftDote.leadingAnchor.constraint(equalTo: leadingAnchor),
            leftDote.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            centrDote.topAnchor.constraint(equalTo: topAnchor),
            centrDote.leadingAnchor.constraint(equalTo: leftDote.trailingAnchor, constant: 8),
            centrDote.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            rightDote.topAnchor.constraint(equalTo: topAnchor),
            rightDote.leadingAnchor.constraint(equalTo: centrDote.trailingAnchor, constant: 8),
            rightDote.bottomAnchor.constraint(equalTo: bottomAnchor),
            rightDote.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
}
