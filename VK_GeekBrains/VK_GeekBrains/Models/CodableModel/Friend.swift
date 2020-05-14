//
//  Friend.swift
//  VK_GeekBrains
//
//  Created by Станислав on 13.05.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import Foundation

struct Friend: Codable {
    let id: Int
    let firstName: String
    
    enum CodingKeys: String, CodingKey {
        case id, firstName = "first_name"
    }
}
