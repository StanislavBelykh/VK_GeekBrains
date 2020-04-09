//
//  Users.swift
//  VK_GeekBrains
//
//  Created by Станислав on 31.03.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import Foundation

struct Users {
    var list = [User]()
    init() {
        list = [
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
    }
}

struct User {
    let name: String
    let avatar: String
    let image: [String]
}

