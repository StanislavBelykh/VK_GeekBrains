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
        layer.borderWidth = 2
        layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        layer.cornerRadius = frame.height/2
        layer.masksToBounds = true
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
}
