//
//  PhotoNews.swift
//  VK_GeekBrains
//
//  Created by Станислав Белых on 25.06.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import Foundation

struct PhotoNews: Codable {
    let id: Int?
    let ownerID: Int?
    let sizes: [SizeNews]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case ownerID = "owner_id"
        case sizes
    }
}
struct SizeNews: Codable {
    let type: String?
    let url: String?
}
