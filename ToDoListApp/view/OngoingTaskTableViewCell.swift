//
//  OngoingTaskTableViewCell.swift
//  ToDoListApp
//
//  Created by Hansom Cho on 2022/03/19.
//

import UIKit

class OngoingTaskTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    
    func configure(with task: Task) {
        titleLable.text = task.title
    }
    
    @IBAction func actionButtonTapped(_ sender: UIButton){
        
    }
    
}

