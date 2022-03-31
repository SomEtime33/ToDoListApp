//
//  Animatable.swift
//  ToDoListApp
//
//  Created by Hansom Cho on 2022/03/30.
//
import Loaf
import Foundation

protocol Animatable {
    
}

extension Animatable where Self: UIViewController {
    
    func showToast(state: Loaf.State, message: String, location: Loaf.Location = .top, duration: TimeInterval = 1.0) {
        DispatchQueue.main.async {
            Loaf(message,
                 state: .info,
                 location: location,
                 sender: self)
                .show(.custom(duration))
        }
    }
    
}
