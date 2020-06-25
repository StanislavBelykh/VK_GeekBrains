//
//  NewsModel.swift
//  VK_GeekBrains
//
//  Created by Станислав on 14.05.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import UIKit

struct NewsModel: Codable {
    let postID: Int
    let text: String
    let date: Double
    let attachments: [Attachment]?
    let likes: LikeModel
    let comments: CommentModel
    var photosURL: [String]? {
        get {
            let photosURL = attachments?.compactMap{ $0.photo?.sizes?.last?.url }
            return photosURL
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case text
        case date
        case likes
        case comments
        case attachments
        
    }
    
    func getStringDate() -> String {
        let dateFormatter = DateFormatterVK()
        return dateFormatter.convertDate(timeIntervalSince1970: date)
    }
}

struct Attachment: Codable {
    let type: String?
    let photo: PhotoNews?
}
struct LikeModel: Codable {
    let count: Int
}
struct CommentModel: Codable {
    let count: Int
}
