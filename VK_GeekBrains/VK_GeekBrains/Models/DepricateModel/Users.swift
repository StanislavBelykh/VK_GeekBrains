//
//  Users.swift
//  VK_GeekBrains
//
//  Created by Станислав on 31.03.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import Foundation

struct Users {
    var list = [
        User(name: "Cheburator1", avatar: "Cheburashka", image: ["Che1","Che2","Che3","Che4"]),
        User(name: "SpongeBob", avatar: "SpongeBob", image: ["SpongeBob1","SpongeBob2","SpongeBob3","SpongeBob4","SpongeBob5"]),
        User(name: "Voodi", avatar: "Voodi", image: ["Voodi1","Voodi2"]),
        
        User(name: "Cheburator2", avatar: "Cheburashka", image: ["Che1","Che2","Che3","Che4"]),
        User(name: "SpongeBob", avatar: "SpongeBob", image: ["SpongeBob1","SpongeBob2","SpongeBob3","SpongeBob4","SpongeBob5"]),
        User(name: "Voodi", avatar: "Voodi", image: ["Voodi1","Voodi2"]),
        
        User(name: "Cheburator3", avatar: "Cheburashka", image: ["Che1","Che2","Che3","Che4"]),
        User(name: "SpongeBob", avatar: "SpongeBob", image: ["SpongeBob1","SpongeBob2","SpongeBob3","SpongeBob4","SpongeBob5"]),
        User(name: "Voodi", avatar: "Voodi", image: ["Voodi1","Voodi2"]),
        
        User(name: "Cheburator4", avatar: "Cheburashka", image: ["Che1","Che2","Che3","Che4"]),
        User(name: "SpongeBob", avatar: "SpongeBob", image: ["SpongeBob1","SpongeBob2","SpongeBob3","SpongeBob4","SpongeBob5"]),
        User(name: "Voodi", avatar: "Voodi", image: ["Voodi1","Voodi2"]),
        
        User(name: "Cheburator5", avatar: "Cheburashka", image: ["Che1","Che2","Che3","Che4"]),
        User(name: "SpongeBob", avatar: "SpongeBob", image: ["SpongeBob1","SpongeBob2","SpongeBob3","SpongeBob4","SpongeBob5"]),
        User(name: "Voodi", avatar: "Voodi", image: ["Voodi1","Voodi2"])

    ]
    
    func getSortedUsers(searchText: String?) -> [Character:[User]]{
        var tempUsers: [User]
        if let text = searchText?.lowercased(), searchText != "" {
            tempUsers = list.filter{ $0.name.lowercased().contains(text)}
        } else {
            tempUsers = list
        }
        let sortedUsers = Dictionary.init(grouping: tempUsers) { $0.name.lowercased().first! }
            .mapValues{ $0.sorted{ $0.name.lowercased() < $1.name.lowercased() } }
        return sortedUsers
    }
}

struct User {
    let name: String
    let avatar: String
    let image: [String]
}

