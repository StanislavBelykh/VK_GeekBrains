//
//  ServerError.swift
//  VK_GeekBrains
//
//  Created by Станислав on 13.05.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import Foundation

enum ServerError: Error {
    case noDataProvided
    case failedToDecode
    case errorTask
}
