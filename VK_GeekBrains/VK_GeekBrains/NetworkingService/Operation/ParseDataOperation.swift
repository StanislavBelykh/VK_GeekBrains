//
//  ParseDataOperation.swift
//  VK_GeekBrains
//
//  Created by Станислав Белых on 04.07.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import Foundation

class ParseDataOperation<T:Codable>: Operation {
    
    var outputData: [T]?
    
    override func main() {
        guard let getDataOperation = dependencies.first as? GetDataOperation,
            let data = getDataOperation.data else { return }
        
        guard let dataParsed = try? JSONDecoder()
            .decode(Response<T>.self, from: data).response.items else {
                print(ServerError.failedToDecode)
                return
        }
        outputData = dataParsed
    }
}
