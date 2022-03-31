//
//  DoneTaskTableViewCell.swift
//  ToDoListApp
//
//  Created by Hansom Cho on 2022/03/30.
//

import UIKit

class DoneTaskTableViewCell: UITableViewCell {
    
    var actionButtonDidTap:(() -> Void)?
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(with task: Task){
        titleLabel.text = task.title
    }
    
    @IBAction func actionButtonTapped(_sender: UIButton) {
        actionButtonDidTap?()
    }
    
}
