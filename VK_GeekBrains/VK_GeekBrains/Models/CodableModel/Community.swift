//
//  Community.swift
//  VK_GeekBrains
//
//  Created by Станислав on 13.05.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import UIKit

struct Community: Codable {
    let id: Int
    let name: String
    let avatarURL: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, avatarURL = "photo_50"
    }
    
    func getAvatarImage(for imageView: inout UIImageView) {
        imageView.loadImage(by: avatarURL)
    }
}
