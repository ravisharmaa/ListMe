//
//  Date+Extension.swift
//  ListMe
//
//  Created by Ravi Bastola on 10/31/20.
//

import Foundation


extension Date {
    
    static var YYYYMMDDHMMSSFormat: String {
        let date = Self()
        let df = DateFormatter()
        df.dateFormat = DateFormatters.YYYYMMDDHHMMSS.description
        return df.string(from: date)
    }
}
