//
//  Response.swift
//  VK_GeekBrains
//
//  Created by Станислав on 13.05.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import Foundation

class Response<T: Codable>: Codable {
    let response: Items<T>
}
class Items<T: Codable>: Codable {
    let items: [T]
}

class ResponseJoin: Codable {
    let response: Int
}
