//
//  CalendarViewDelegate.swift
//  ToDoListApp
//
//  Created by Hansom Cho on 2022/03/30.
//

import Foundation

protocol CalendarViewDelegate: class {
    func calendarViewDidSelectDate(date: Date)
    func calendarViewDidTapRemoveButton()
}
