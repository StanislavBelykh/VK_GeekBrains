//
//  SavingDataOperation.swift
//  VK_GeekBrains
//
//  Created by Станислав Белых on 04.07.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import Foundation
import RealmSwift

class SavingDataOperation<T: Object & Codable>: Operation {
    
    override func main() {
        guard let parseDataOperation = dependencies.first as? ParseDataOperation<T>,
            let outputData = parseDataOperation.outputData else { return }
        
       do {
            let realm = try Realm()
        let oldValues = realm.objects(T.self)
            realm.beginWrite()
            realm.delete(oldValues)
            realm.add(outputData)
            try realm.commitWrite()
            print("Completed Saving")
        } catch {
            print(error)
        }
    }
}
