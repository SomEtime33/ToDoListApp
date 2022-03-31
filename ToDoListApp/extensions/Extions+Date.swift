//
//  Extions+Date.swift
//  ToDoListApp
//
//  Created by Hansom Cho on 2022/03/30.
//

import Foundation

extension Date {
    
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMM d, yyyy"
        return formatter.string(from: self)
    }
    
    func toRelativeString() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        let today = Date()
        return formatter.localizedString(for: self, relativeTo: today)
    }
    
    func isOverDue() -> Bool { //기한 지났는지 체크 (오늘 기준)
        let today = Date()
        return self < today
    }
    
}
