//
//  Friend.swift
//  VK_GeekBrains
//
//  Created by Станислав on 13.05.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import UIKit

struct Friend: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let avatarURL: String
    
    
    enum CodingKeys: String, CodingKey {
        case id, firstName = "first_name", lastName = "last_name", avatarURL = "photo_100"
    }
    
}
