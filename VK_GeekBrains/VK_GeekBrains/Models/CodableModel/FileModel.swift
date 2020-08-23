//
//  FileModel.swift
//  VK_GeekBrains
//
//  Created by Станислав on 13.05.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import Foundation

class FileModel: Codable {
    let date: Double
    let ext: String
    let id: Int
    let ownerID: Int
    let size: Int
    let title: String
    let type: TypeFile
    let url: String
    var destinationURL: URL?
    var state: StateFile?

    enum CodingKeys: String, CodingKey {
        case date
        case ext
        case id
        case ownerID = "owner_id"
        case size
        case title
        case type
        case url
    }
}
// MARK: - TypeFile
enum TypeFile: Int, Codable {
    case textDocument = 1
    case archiv = 2
    case gif = 3
    case image = 4
    case audio = 5
    case video = 6
    case book = 7
    case unknown = 8
    
}
extension TypeFile {
    
    func getName() -> String {
        switch self {
        case .textDocument :
            return "Text Document" //— текстовые документы;
        case .archiv :
            return "Archiv"        //— архивы;
        case .gif :
            return "Gif"           //— gif;
        case .image :
            return "Image"         //— изображения;
        case .audio :
            return "Audio"         //— аудио;
        case .video :
            return "Video"         //— видео;
        case .book :
            return "Book"          //— электронные книги;
        default:
            return "Unknown"       //— неизвестно.
        }
    }
    func  getIconName() -> String {
        switch self {
        case .textDocument :
            return "text" //— текстовые документы;
        case .archiv :
            return "archiv"        //— архивы;
        case .gif :
            return "video"           //— gif;
        case .image :
            return "image"         //— изображения;
        case .audio :
            return "music"         //— аудио;
        case .video :
            return "video"         //— видео;
        case .book :
            return "text"          //— электронные книги;
        default:
            return "file"       //— неизвестно.
        }
    }
}

enum StateFile {
    case inCloud
    case loading
    case loaded
}
