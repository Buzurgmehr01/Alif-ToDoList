//
//  TaskManager.swift
//  CoreDataDemo
//
//  Created by Majidov Buzurgmehr on 17/09/23.
//

import CoreData

class Taskmanager{
    private let coreDataManager: CoreDataManager
    
    init(coreDataManeger: CoreDataManager) {
        self.coreDataManager = coreDataManeger
    }
    
    func getTasks() -> [SaveEntity]{
        
        let featchRequest: NSFetchRequest<SaveEntity> = SaveEntity.fetchRequest()
        
        do{
            let tasks = try coreDataManager.context.fetch(featchRequest)
            return tasks
            
        }catch{
            print(error.localizedDescription)
        }
        return []
    }
    
    func saveTask(title: String, description: String, completion: @escaping ([SaveEntity]?) -> Void) {
        
        let task = SaveEntity(context: coreDataManager.context)
        task.title = title
        task.taskDescription = description
        do {
            try coreDataManager.context.save()
            let task = getTasks()
            completion(task)
        } catch {
            print("Failed to save user: \(error.localizedDescription)")
        }
    }
    
    func updateTask(title: String, exeutor: String, newTitleName: String){
        let fetchRequest = SaveEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        
        do{
            let task = try coreDataManager.context.fetch(fetchRequest).first
            task?.title = newTitleName
            task?.taskDescription = exeutor
            coreDataManager.saveContext()
                        
        }catch{
            print(error)
        }
    }
    
    func deleteTask(task: SaveEntity){
        coreDataManager.context.delete(task)
        coreDataManager.saveContext()
    }
}
