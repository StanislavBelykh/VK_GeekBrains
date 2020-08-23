//
//  Photo.swift
//  VK_GeekBrains
//
//  Created by Станислав on 14.05.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import Foundation
import RealmSwift

class Photo: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var ownerID: Int = 0
    var sizes =  List<Size>()
    
    enum CodingKeys: String, CodingKey {
        case id
        case ownerID = "owner_id"
        case sizes
    }
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.ownerID = try values.decode(Int.self, forKey: .ownerID)
        self.sizes = try values.decode( List<Size>.self, forKey: .sizes)
    }
    override static func primaryKey() -> String? {
        return "id"
    }
    override static func indexedProperties() -> [String] {
        return ["ownerID"]
    }
    
}

class Size: Object, Codable {
    @objc dynamic var type: String = ""
    @objc dynamic var url: String = ""
}

