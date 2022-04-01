//
//  OnboardingViewController.swift
//  ToDoListApp
//
//  Created by Hansom Cho on 2022/03/31.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    private let navigationManager = NavtigationManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showLoginScreen", let destination = segue.destination as? LoginViewController {
            destination.delegate = self
        }
    }
    
    @IBAction func getStartedButtonTapped(_sender: UIButton) {
        performSegue(withIdentifier: "showLoginScreen", sender: nil)
    }
}

extension OnboardingViewController: LoginVCDelegate {
    func didLogin() {
        
        presentedViewController?.dismiss(animated: true, completion: { [unowned self] in
            self.navigationManager.show(scene: .tasks)
        })
    }
    
    
    
    
}
