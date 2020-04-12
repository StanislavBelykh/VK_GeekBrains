//
//  News.swift
//  VK_GeekBrains
//
//  Created by Станислав on 10.04.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import Foundation

struct NewsFabric {
    var list = [
        News(avatar: "SpongeBob",
             creator: "SpongeBob",
             date: Date(timeIntervalSinceNow: 0),
             title: "Новости дна",
             photos: ["SpongeBob1","SpongeBob2","SpongeBob3","SpongeBob4","SpongeBob5"],
             likeCount: 5,
             commentCount: 2,
             counterAppears: 0),
//        News(avatar: "SpongeBob",
//             creator: "SpongeBob",
//             date: Date(timeIntervalSinceNow: 0),
//             title: "Новости дна",
//             photos: ["SpongeBob1","SpongeBob2","SpongeBob3","SpongeBob4","SpongeBob5"],
//             likeCount: 5,
//             commentCount: 2,
//             counterAppears: 0)
        
        
    ]
}

struct News {
    let avatar: String
    let creator: String
    let date: Date
    var title: String
    var photos: [String]
    
    var likeCount: Int
    var commentCount: Int
    var counterAppears: Int
}
