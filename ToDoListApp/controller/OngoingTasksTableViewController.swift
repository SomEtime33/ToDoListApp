//
//  OngoingTasksTableViewController.swift
//  ToDoListApp
//
//  Created by Hansom Cho on 2022/03/11.
//

import UIKit

class OngoingTasksTableViewController: UITableViewController {
    
    private let databaseManager = DatabeseManager()
    
    
    private var tasks: [Task] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTasksListener()
    }
    
    private func addTasksListener() {
        
        databaseManager.addTasksListener { [weak self](result) in
            switch result {
            case .success(let tasks):
                self?.tasks = tasks
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
}

extension OngoingTasksTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)as! OngoingTaskTableViewCell
        let task = tasks[indexPath.row]
        cell.configure(with: task)
        return cell
    }
}
