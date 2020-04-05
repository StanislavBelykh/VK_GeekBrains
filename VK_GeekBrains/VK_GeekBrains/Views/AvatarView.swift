//
//  AvatarView.swift
//  VK_GeekBrains
//
//  Created by Станислав on 03.04.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import UIKit

class  AvatarView: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
  
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
         layer.borderWidth = SettingsSinglton.shared.borderWidth
         layer.borderColor = SettingsSinglton.shared.borderColor
         layer.cornerRadius = SettingsSinglton.shared.cornerRadius
         layer.masksToBounds = true
  
    }
}
