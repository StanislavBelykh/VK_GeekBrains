//
//  Community.swift
//  VK_GeekBrains
//
//  Created by Станислав on 13.05.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import UIKit

class Community: Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var avatarURL: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case avatarURL = "photo_50"
    }
}
