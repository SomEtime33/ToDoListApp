//
//  TasksVCDelegate.swift
//  ToDoListApp
//
//  Created by Hansom Cho on 2022/03/19.
//

import Foundation

protocol NewTasksVDCelegate: class {
    func didAddTask(_ task: Task)
    func didEditTask(_ task: Task)
}
