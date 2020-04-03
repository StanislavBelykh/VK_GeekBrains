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
        layer.cornerRadius = frame.height/2
        layer.shadowColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        layer.shadowRadius = 8
        layer.shadowOffset = .zero
        layer.shadowOpacity = 1
    }
}
