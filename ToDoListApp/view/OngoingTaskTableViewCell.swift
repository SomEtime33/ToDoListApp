//
//  OngoingTaskTableViewCell.swift
//  ToDoListApp
//
//  Created by Hansom Cho on 2022/03/19.
//

import UIKit

class OngoingTaskTableViewCell: UITableViewCell {
    
    var actionButtonDidTap:(() -> Void)?
    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    
    func configure(with task: Task) {
        titleLable.text = task.title
        deadlineLabel.text = task.deadline?.toRelativeString()
        
        if task.deadline?.isOverDue() == true {
            deadlineLabel.textColor = .red
            deadlineLabel.font = UIFont(name: "AvenirNext-Medium", size: 12)
        }
    }
    
    @IBAction func actionButtonTapped(_ sender: UIButton){
        actionButtonDidTap?()
    }
    
}

