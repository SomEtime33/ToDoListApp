//
//  LoadingViewController.swift
//  ToDoListApp
//
//  Created by Hansom Cho on 2022/03/31.
//

import UIKit

class LoadingViewController: UIViewController {
    
    private let authManager = AuthManager()
    private let navigationManager = NavtigationManager.shared
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showInitialScreen()
    }
    
    //로그인 했을 경우와 하지 않았을 경우의 initial screen 결정
    func showInitialScreen() {
        if authManager.isUserLoggedIn() {
            navigationManager.show(scene: .tasks)
        } else {
            navigationManager.show(scene: .onboarding)
        }
    }
    
}
