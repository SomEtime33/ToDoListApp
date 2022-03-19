//
//  DatabaseManager.swift
//  ToDoListApp
//
//  Created by Hansom Cho on 2022/03/19.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

class DatabeseManager {
    private let db = Firestore.firestore()
    
    private lazy var tasksCollection = db.collection("tasks")
    private var listener: ListenerRegistration?
    
    func addTask(_ task: Task, completion: @escaping (Result<Void, Error>) -> Void) {
        
        do{
            _ = try tasksCollection.addDocument(from: task, completion: { (error) in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            })
        }catch(let error) {
            completion(.failure(error))
        }

    }
    
    func addTasksListener(completion: @escaping (Result<[Task], Error>) -> Void) {
        
        
        listener = tasksCollection.addSnapshotListener({ (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                
                var tasks = [Task]()
                
                snapshot?.documents.forEach({ (document) in
                    
                    if let task = try? document.data(as: Task.self){
                        tasks.append(task)
                    }
                })
                completion(.success(tasks))
                
            }
        })
    }
    
}
