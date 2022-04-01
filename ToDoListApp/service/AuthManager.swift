//
//  AuthManager.swift
//  ToDoListApp
//
//  Created by Hansom Cho on 2022/03/31.
//

import Foundation
import FirebaseAuth

class AuthManager {
    
    let auth = Auth.auth()
    
    func login(withEmail email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        auth.signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func sighUp(withEmail email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        
        auth.createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func logout(completion: (Result<Void, Error>) -> Void) {
        do {
            try auth.signOut()
            completion(.success(()))
        } catch (let error) {
            completion(.failure(error))
        }
    }
    
    func isUserLoggedIn() -> Bool {
        return auth.currentUser != nil
        //currentUser 존재할 경우 return true (= loggedIn)
    }
    
    
    func getUserID() -> String? {
        return auth.currentUser?.uid
    }
    
}
