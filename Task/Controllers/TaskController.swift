//
//  TaskController.swift
//  Task
//
//  Created by John Tate on 8/29/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import Foundation
import CoreData

class TaskController{
  
    var tasks: [Task] = []
    
    init() {
        tasks = fetchTasks()
    }
    
    func fetchTasks() -> [Task] {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        return (try? CoreDataStack.context.fetch(request)) ?? []
    }
    
    // shared instance
    
    static let shared = TaskController()
    
    // CRUD
    
    func add(taskWithName name: String, notes: String?, due: Date?) {
        let _ = Task(name: name, notes: notes, due: due)
        saveToPersistentStore()
        tasks = fetchTasks()
    }
    
    func update(task: Task, name: String, notes: String?, due: Date?) {
        task.name = name
        task.notes = notes
        task.due = due
        saveToPersistentStore()
        tasks = fetchTasks()
    }
    
    func remove(task: Task) {
        task.managedObjectContext?.delete(task)
        saveToPersistentStore()
        tasks = fetchTasks()
    }
    
    func toggleIsCompleteFor(task: Task) {
        task.isComplete = !task.isComplete
        saveToPersistentStore()
    }
    
    
    
    // Persistence
    
    func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch {
            print("There was an error in \(#function) : \(error) \(error.localizedDescription)")
        }
    }

}
