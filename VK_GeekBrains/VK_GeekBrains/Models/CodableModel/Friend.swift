//
//  Friend.swift
//  VK_GeekBrains
//
//  Created by Станислав on 13.05.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import UIKit
import RealmSwift

class Friend: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var avatarURL: String = ""
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case avatarURL = "photo_100"
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    override static func indexedProperties() -> [String] {
        return ["firstName", "lastName"]
    }
}
