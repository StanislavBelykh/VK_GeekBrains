//
//  Session.swift
//  VK_GeekBrains
//
//  Created by Станислав on 09.05.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import Foundation

class SessionApp {
    static var shared = SessionApp()
    
    var token: String?
    var userID: Int?
    
    private init() {}
}
