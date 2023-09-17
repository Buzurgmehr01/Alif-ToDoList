//
//  CoreData.swift
//  CoreDataDemo
//
//  Created by Majidov Buzurgmehr on 03/09/23.
//

import CoreData
import UIKit

class CoreDataManager {
    
    public static let shared = CoreDataManager()
    

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
    
    var context: NSManagedObjectContext{
        get{
            return persistentContainer.viewContext
        }
    }

    
    
    func saveContext(){
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
    

}

