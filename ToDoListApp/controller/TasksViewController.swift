//
//  ViewController.swift
//  ToDoListApp
//
//  Created by Hansom Cho on 2022/03/10.
//

import UIKit

class TasksViewController: UIViewController, Animatable {

    @IBOutlet weak var menuSegmentedControl: UISegmentedControl!
    @IBOutlet weak var ongoingTasksContainerView: UIView!
    @IBOutlet weak var doneTasksContainerView: UIView!
    
    private let databaseManager = DatabeseManager()
    private let authManager = AuthManager()
    private let navigationManager = NavtigationManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSegmentedControl()
        
        
     
    }
    private func setupSegmentedControl() {
        menuSegmentedControl.removeAllSegments()
        
        MenuSection.allCases.enumerated().forEach { (index, section) in
            menuSegmentedControl.insertSegment(withTitle: section.rawValue, at: index, animated: false)
            
        }
        menuSegmentedControl.selectedSegmentIndex = 0
        showContainerView(for: .ongoing)
    }
    
    private func logoutUser() {
        authManager.logout { [unowned self] (result) in
            switch result {
            case .success:
                navigationManager.show(scene: .onboarding)
            case .failure(let error):
                self.showToast(state: .error, message: error.localizedDescription)
            }
        }
    }
    
    private func showMenuOption() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let logoutAction = UIAlertAction(title: "Logout", style: .default) { [unowned self] _ in
            self.logoutUser()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(logoutAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            showContainerView(for: .ongoing)
        case 1:
            showContainerView(for: .done)
        default: break
        }
        
    }
    
    @IBAction func menuButtonTapped(_sender: UIButton) {
        showMenuOption()
    }
    
    private func showContainerView(for section: MenuSection) {
        switch section {
        case .ongoing:
            ongoingTasksContainerView.isHidden = false
            doneTasksContainerView.isHidden = true
        case .done:
            ongoingTasksContainerView.isHidden = true
            doneTasksContainerView.isHidden = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNewTask",
           let destination = segue.destination as? NewTaskViewController{
            destination.delegate = self
        } else if segue.identifier == "showOngoingTasks" {
            let destination = segue.destination as?
            OngoingTasksTableViewController
            destination?.delegate = self
        } else if segue.identifier == "showEditTask",
            let destination = segue.destination as? NewTaskViewController,
            let taskToEdit = sender as? Task {
            destination.delegate = self
            destination.taskToEdit = taskToEdit
        }
    }
    
    private func deleteTask(id: String) {
        databaseManager.deleteTask(id: id) { [weak self](result) in
            switch result {
            case .success :
                self?.showToast(state: .success, message: "Task deleted Successfully")
            case .failure(let error):
                self?.showToast(state: .error, message: error.localizedDescription)
            }
        }
    }
    
    private func editTask(task: Task) {
        performSegue(withIdentifier: "showEditTask", sender: task)
    }
 
    @IBAction func addTaskButtonTapped(_sender: UIButton) {
        performSegue(withIdentifier: "showNewTask", sender: nil)
    }

}
extension TasksViewController: OngoingTasksTVCDelegate {
    
    func showOptions(for task: Task) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [unowned self] _ in
            guard let id = task.id else { return }
            self.deleteTask(id: id)
          
            
        }
        let editAction = UIAlertAction(title: "Edit", style: .default) { [unowned self] _ in
            self.editTask(task: task)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        alertController.addAction(editAction)
        present(alertController, animated: true, completion: nil)
    }
}
extension TasksViewController: NewTasksVDCelegate {
    
    func didEditTask(_ task: Task) {
        presentedViewController?.dismiss(animated: true, completion: {
            guard let id = task.id else { return }
            self.databaseManager.editTask(id: id, title: task.title, deadline: task.deadline) { [weak self] (result) in
                switch result {
                case .success:
                    self?.showToast(state: .success, message: "Task Updated Successfully")
                case .failure(let error):
                    self?.showToast(state: .error, message: error.localizedDescription)
                }
            }
        })
    }
    
    func didAddTask(_ task: Task) {
        
        presentedViewController?.dismiss(animated: true, completion: { [unowned self] in
            self.databaseManager.addTask(task) { [weak self] (result) in
                switch result {
                case .success:break
                case .failure(let error):
                    self?.showToast(state: .error, message: error.localizedDescription)
                }
            }
        })
    }
}
