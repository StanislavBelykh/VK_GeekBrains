//
//  ResponseNews.swift
//  VK_GeekBrains
//
//  Created by Станислав Белых on 25.06.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import Foundation

struct ResponseNews: Codable {
    let response: ItemsNews
}

struct ItemsNews: Codable {
    let items: [NewsModel]
    let profiles: [ProfileNews]
    let groups: [GroupNews]
    let nextFrom: String
    
    enum CodingKeys: String, CodingKey {
        case items
        case profiles
        case groups
        case nextFrom = "next_from"
    }
}

struct ProfileNews: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let avatarURL: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName
        case lastName
        case avatarURL = "photo_100"
    }
}

struct GroupNews: Codable {
    let id: Int
    let name: String
    let avatarURL: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case avatarURL = "photo_100"
    }
}
