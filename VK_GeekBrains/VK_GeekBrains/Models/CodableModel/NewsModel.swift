//
//  NewsModel.swift
//  VK_GeekBrains
//
//  Created by Станислав on 14.05.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import UIKit

class ResponseNews: Codable {
    let response: ItemsNews
    
}

class ItemsNews: Codable {
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

class ProfileNews: Codable {
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

class GroupNews: Codable {
    let id: Int
    let name: String
    let avatarURL: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case avatarURL = "photo_100"
    }
}

class NewsModel: Codable {
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
    var photos: [UIImage]? {
        get {
            var images: [UIImage]?
            let photosURL = attachments?.compactMap{ $0.photo?.sizes?.last?.url }

            let cache = URLCache.shared
            if let photosURL = photosURL {
                for photoURL in photosURL {
                    guard let url = URL(string: photoURL) else { return nil}
                    let request = URLRequest(url: url)

                    if let imageDate = cache.cachedResponse(for: request)?.data {
                        if let image = UIImage(data: imageDate) {
                            images?.append(image)
                        }
                    } else {
                        URLSession.shared.dataTask(with: request) { (data, response, _ ) in
                            guard let data = data, let response = response else {
                                return
                            }
                            let cacheResponse = CachedURLResponse(response: response, data: data)
                            cache.storeCachedResponse(cacheResponse, for: request)
                            DispatchQueue.main.async {
                                if let image = UIImage(data: data) {
                                    images?.append(image)
                                }
                            }
                        }.resume()
                    }
                    return images
                }
            }
            return images
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

class PhotoNews: Codable {
    let id: Int?
    let ownerID: Int?
    let sizes: [SizeNews]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case ownerID = "owner_id"
        case sizes
    }
}
class SizeNews: Codable {
    let type: String?
    let url: String?
}

struct LikeModel: Codable {
    let count: Int
}
struct CommentModel: Codable {
    let count: Int
}
