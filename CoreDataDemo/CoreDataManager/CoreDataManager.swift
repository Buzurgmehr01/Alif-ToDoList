//
//  CoreData.swift
//  CoreDataDemo
//
//  Created by Majidov Buzurgmehr on 03/09/23.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    static let shared = CoreDataManager()
    public var saveTask:[SaveEntity] = []
        
    init(){}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataDemo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveCotext(){
        let context = persistentContainer.viewContext
        if context.hasChanges{
            do{
                try context.save()
            }catch{
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func createUser(login: String, password: String) {
        let context = persistentContainer.viewContext
        let user = Users(context: context)
        user.login = login
        user.password = password
        saveCotext()
    }
    
    func authUser(login: String, password: String) -> Bool {
        let context = persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Users> = Users.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "login = %@ AND password = %@", login, password)
        
        do {
            let matchingUsers = try context.fetch(fetchRequest)
            return !matchingUsers.isEmpty
        } catch {
            print("Failed to fetch user: \(error.localizedDescription)")
            return false
        }
    }
    
    func saveTask(title: String, description: String) {
        let context = persistentContainer.viewContext
        let task = SaveEntity(context: context)
        task.title = title
        task.taskDescription = description
        
        do {
            try context.save()
            saveTask.append(task)
        } catch {
            print("Failed to save user: \(error.localizedDescription)")
        }
    }
    
    func checkTask(){
        let conteiner = persistentContainer.viewContext
        let featchRequest: NSFetchRequest<SaveEntity> = SaveEntity.fetchRequest()
        
        do{
            saveTask = try conteiner.fetch(featchRequest)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func changeTask(title: String, exeutor: String, newTitleName: String){
        let fetchRequest = SaveEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        
        do{
            let task = try persistentContainer.viewContext.fetch(fetchRequest).first
            task?.title = newTitleName
            task?.taskDescription = exeutor
            saveCotext()
        }catch{
            print(error)

        }
    }
    
    func deleteTask(task: SaveEntity){
        let conteiner = persistentContainer.viewContext
        conteiner.delete(task)
        saveCotext()
    }
}

