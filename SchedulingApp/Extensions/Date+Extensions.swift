//
//  Date+Extensions.swift
//  SchedulingApp
//
//  Created by Hana  Demas on 10/29/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//

import Foundation

// MARK: - converting date into String
extension Date {
    
    //MARK: Methods
   func getFormattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "LLL"
        let monthString = dateFormatter.string(from: self)
    
        dateFormatter.dateFormat = "EEE"
        let dayOfTheWeekString = dateFormatter.string(from: self)
    
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: self)
        let dayOfMonth = components.day ?? 0
    
        return dayOfTheWeekString + ", " + monthString + " \(dayOfMonth)"
    }
    
    func getFormatedHours() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "hh:mm a"
        let hourString = dateFormatter.string(from: self)
        
        return hourString
    }
}

// MARK: - converting string into date
extension String {
    
    func getDateFromString() -> Date? {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormat.locale = Locale.current
        return dateFormat.date(from: self)
    }
}
