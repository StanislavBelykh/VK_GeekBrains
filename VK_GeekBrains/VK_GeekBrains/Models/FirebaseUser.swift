//
//  FirebaseUser.swift
//  VK_GeekBrains
//
//  Created by Станислав Белых on 04.06.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import Foundation
import Firebase

// TODO: - Сделать как объект
class FirebaseUser {
    let id: Int
    var communities: [FirebaseCommunity] = []
    let ref: DatabaseReference?
    var toFire: [String: Any] {
        return communities.map{ $0.toAnyObject() }.reduce([:]) { $0.merging($1) { (current, _) in current } }
    }

    init(id: Int){
        self.id = id
        self.ref = nil
        self.communities = []
    }
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: Any],
            let id = value["id"] as? Int,
            let communities = value["communities"] as? [FirebaseCommunity] else {
                return nil
        }
        self.ref = snapshot.ref
        self.id = id
        self.communities = communities
    }

    func toAnyObject() -> [String: Any] {
        return [
            "id": id,
            "communities" : toFire
        ]
    }
}
class FirebaseCommunity {
    
    let name: String
    let id: Int
    let ref: DatabaseReference?
    
    init(name: String, id: Int) {

        self.ref = nil
        self.name = name
        self.id = id
    }
    
    init?(snapshot: DataSnapshot) {

        guard
            let value = snapshot.value as? [String: Any],
            let id = value["id"] as? Int,
            let name = value["name"] as? String else {
                return nil
        }
        
        self.ref = snapshot.ref
        self.name = name
        self.id = id
    }
    
    func toAnyObject() -> [String: Any] {

        return [
            "name": name,
            "id": id
        ]
    }
}
