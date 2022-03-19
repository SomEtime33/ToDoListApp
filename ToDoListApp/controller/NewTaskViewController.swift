//
//  NewTaskViewController.swift
//  ToDoListApp
//
//  Created by Hansom Cho on 2022/03/16.
//

import UIKit
import Combine

class NewTaskViewController: UIViewController {
   
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var saveButton: UIButton!
    
    private var substribers = Set<AnyCancellable>()
    @Published private var taskString: String?
    
    weak var delegate: TasksVDCelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupGesture()
        observeKeyboard()
        observeForm()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        taskTextField.becomeFirstResponder()
        
        
    }
    
    private func observeForm() {
    
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification).map({
            ($0.object as? UITextField)?.text
        }).sink { [unowned self] (text) in
            self.taskString = text
        }.store(in: &substribers)
        
        
        $taskString.sink { (text) in
            self.saveButton.isEnabled = text?.isEmpty == false
        }.store(in: &substribers)
        
    }
    
    private func setupView() {
        backgroundView.backgroundColor = UIColor.init(white: 0.3, alpha: 0.4)
        containerViewBottomConstraint.constant = -containerView.frame.height
    }
    
    private func setupGesture() { //다른 곳 누르면 키보드 들어감
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissViewController))
        view.addGestureRecognizer(tapGesture)
    }
    
    
    private func observeKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    @objc func keyboardWillShow(_ notification: Notification) {
       let keyboardHeight = getKeyboardHeight(notification: notification)
        
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: { [unowned self] in
            self.containerViewBottomConstraint.constant = keyboardHeight - (200 + 8)
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        

        
        
        
    }
    @objc func keyboardWillHide(_ notification: Notification) {
        containerViewBottomConstraint.constant = -containerView.frame.height
        
    }
    
    
    
    
    private func getKeyboardHeight(notification: Notification) -> CGFloat {
        guard let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height else {return 0}
        return keyboardHeight
    }
    
    @objc private func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func calendarButtonTapped(_ sender: Any) {
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let taskString = self.taskString else {return}
        let task = Task(title: taskString)
        delegate?.didAddTask(task)
        
    }
    
    
    
}
