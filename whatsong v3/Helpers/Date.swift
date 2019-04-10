//
//  Date.swift
//  whatsong v3
//
//  Created by Tom Andrew on 5/4/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

extension String    {
    
    func toDate(stringFormat format: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        let date = dateFormatter.date(from:self)!
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
        
        return calendar.date(from:components)!
    }
}

extension Date  {
    
    func toString( dateFormat format: String ) -> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: self)
    }
    
    func getDay() -> Int {
        let calendar = Calendar.current
        
        return calendar.component(.day, from: self)
    }
    
    func getMonth() -> Int {
        let calendar = Calendar.current
        
        return calendar.component(.month, from: self)
    }
    
    func getYear() -> Int {
        let calendar = Calendar.current
        
        return calendar.component(.year, from: self)
    }
    
    func getDayEnding() -> String {
        let day = self.getDay()
        var newDayNumber = day
        if day < 10 {
            newDayNumber = day
        } else {
            newDayNumber = day % 10
        }
        if newDayNumber == 0 {
            return "\(day)th "
        }
        if newDayNumber == 1 {
            return "\(day)st "
        }
        if newDayNumber == 2 {
            return "\(day)nd "
        }
        if newDayNumber == 3 {
            return "\(day)rd "
        }
        if newDayNumber > 3 {
            return "\(day)th "
        }
        
        return "\(day) "
    }
    
}
