//
//  NavtigationManager.swift
//  ToDoListApp
//
//  Created by Hansom Cho on 2022/03/31.
//

import UIKit

//transit user from viewController -> any other viewController
class NavtigationManager {
    
    static let shared = NavtigationManager()
    
    private init() { }
    
    
    enum Scene {
        case onboarding
        case tasks
    }
    
    func show(scene: Scene) {
        
        var controller: UIViewController
        
        switch scene {
        case .onboarding:
            controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "OnboardingViewController")     
        case .tasks:
            controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TasksNavitationController")
        }
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window else { return }
        window.rootViewController = controller
        UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve, animations: {}, completion: nil)
    }
    
}
