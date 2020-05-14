//
//  Photo.swift
//  VK_GeekBrains
//
//  Created by Станислав on 14.05.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import Foundation

struct Photo: Codable {
    let id: Int
    let ownerID: Int
    let sizes: [Size]
    enum CodingKeys: String, CodingKey {
        case id, ownerID = "owner_id", sizes
    }
}

struct Size: Codable {
    let type: String?
    let src: String?
}
