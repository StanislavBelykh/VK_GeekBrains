//
//  Friend.swift
//  VK_GeekBrains
//
//  Created by Станислав on 13.05.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import UIKit
import RealmSwift

class Friend: Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var avatarURL: String = ""
    
    
    enum CodingKeys: String, CodingKey {
        case id, firstName = "first_name", lastName = "last_name", avatarURL = "photo_100"
    }
    
}
