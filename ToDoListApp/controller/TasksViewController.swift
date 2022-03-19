//
//  ViewController.swift
//  ToDoListApp
//
//  Created by Hansom Cho on 2022/03/10.
//

import UIKit

class TasksViewController: UIViewController {

    @IBOutlet weak var menuSegmentedControl: UISegmentedControl!
    @IBOutlet weak var ongoingTasksContainerView: UIView!
    @IBOutlet weak var doneTasksContainerView: UIView!
    
    private let databaseManager = DatabeseManager()
    
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
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            showContainerView(for: .ongoing)
        case 1:
            showContainerView(for: .done)
        default: break
        }
        
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
        }
    }
    
    @IBAction func addTaskButtonTapped(_sender: UIButton) {
        performSegue(withIdentifier: "showNewTask", sender: nil)
    }

}
extension TasksViewController: TasksVDCelegate {
    func didAddTask(_ task: Task) {
        
        presentedViewController?.dismiss(animated: true, completion: { [unowned self] in
            self.databaseManager.addTask(task) { (result) in
                switch result {
                case .success:
                    print("yay")
                case .failure(let error):
                    print("error: \(error.localizedDescription)")
                }
            }
        })
        

    }
    
    
}
