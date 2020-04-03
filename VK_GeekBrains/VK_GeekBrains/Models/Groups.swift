//
//  Groups.swift
//  VK_GeekBrains
//
//  Created by Станислав on 31.03.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import Foundation

struct Groups {
    var list = [Group]()
    init() {
        list = [
            Group(name: "Walt Disney", avatar: "disney"),
            Group(name: "Nickelodeon", avatar: "nickelodeon"),
            Group(name: "WarnerBros", avatar: "WarnerBros")
        ]
    }
}

struct Group: Equatable {
    let name: String
    let avatar: String
}
