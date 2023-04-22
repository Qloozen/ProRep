//
//  DateExtensions.swift
//  ProRep
//
//  Created by Qiang Loozen on 21/04/2023.
//

import Foundation

extension Date {
    public func getScheduleday() -> ScheduleDay {
        let dayOfWeek = Calendar.current.component(.weekday, from: Date.now) // Starts from Sunday
        let index = (dayOfWeek - 1 + 6) % 7
        return ScheduleDay.allCases[index]
    }
}
