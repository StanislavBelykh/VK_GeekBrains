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
    var cornerRadius:CGFloat = 35
    var borderColor:CGColor = CGColor(srgbRed: 94/255, green: 170/255, blue: 241/255, alpha: 1)
    
    
    var shadowRadius:CGFloat = 8
    var shadowOpacity:Float = 1
    var shadowColor:CGColor = CGColor(srgbRed: 180/255, green: 156/255, blue: 246/255, alpha: 1)
    
    private init(){}
}
