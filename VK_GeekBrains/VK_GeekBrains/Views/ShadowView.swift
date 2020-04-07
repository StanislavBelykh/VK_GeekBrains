//
//  ShadowView.swift
//  VK_GeekBrains
//
//  Created by Станислав on 03.04.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import UIKit

class ShadowView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setLayout()
        
        NotificationCenter.default.addObserver(self, selector: #selector(setLayout), name: SettingsSinglton.notificationName, object: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    @objc func setLayout(){
        layer.cornerRadius = SettingsSinglton.shared.cornerRadius
        layer.shadowColor = SettingsSinglton.shared.shadowColor
        layer.shadowRadius = SettingsSinglton.shared.shadowRadius
        layer.shadowOffset = .zero
        layer.shadowOpacity = SettingsSinglton.shared.shadowOpacity
    }
}
