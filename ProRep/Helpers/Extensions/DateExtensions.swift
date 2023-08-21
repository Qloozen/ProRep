//
//  DateExtensions.swift
//  ProRep
//
//  Created by Qiang Loozen on 21/04/2023.
//

import Foundation

extension Date {
    public func getDayOfWeek() -> Int {
        let dayOfWeek = Calendar.current.component(.weekday, from: Date.now) // Starts from Sunday
        
        return dayOfWeek == 1 ? 7 : dayOfWeek - 1
    }
}
