//
//  NewsModel.swift
//  VK_GeekBrains
//
//  Created by Станислав on 14.05.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import Foundation

struct NewsModel: Codable {
    let postID: Int
    let text: String
    

    
    enum CodingKeys: String, CodingKey {
        case postID = "post_id", text
    }
}

