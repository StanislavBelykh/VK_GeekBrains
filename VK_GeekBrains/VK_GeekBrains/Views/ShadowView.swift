//
//  ShadowView.swift
//  VK_GeekBrains
//
//  Created by Станислав on 03.04.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import UIKit

class ShadowView: UIView {
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = SettingsSinglton.shared.cornerRadius
        layer.shadowColor = SettingsSinglton.shared.shadowColor
        layer.shadowRadius = SettingsSinglton.shared.shadowRadius
        layer.shadowOffset = .zero
        layer.shadowOpacity = SettingsSinglton.shared.shadowOpacity
    }
}
