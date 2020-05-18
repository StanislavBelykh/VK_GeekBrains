//
//  DateFormatter.swift
//  VK_GeekBrains
//
//  Created by Станислав on 17.05.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import Foundation

class DateFormatterVK {
    let dateFormatter = DateFormatter()
    
    func convertDate(timeIntervalSince1970: Double) -> String{
        dateFormatter.dateFormat = "MM-dd-yyyy"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let date = Date(timeIntervalSince1970: timeIntervalSince1970)
        return dateFormatter.string(from: date)
    }
}
