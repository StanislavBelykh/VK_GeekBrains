//
//  SettingsSinglton.swift
//  VK_GeekBrains
//
//  Created by Станислав on 03.04.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import UIKit

class SettingsSinglton {
    
    static var shared = SettingsSinglton()
    
    var borderWidth:CGFloat = 3
    var cornerRadius:CGFloat = 5
    var borderColor:CGColor = CGColor(srgbRed: 150/255, green: 0, blue: 0, alpha: 1)
    
    
    var shadowRadius:CGFloat = 8
    var shadowOpacity:Float = 1
    var shadowColor:CGColor = CGColor(srgbRed: 1, green: 1, blue: 1, alpha: 1)
    
    private init(){}
}
