//
//  UserManager.swift
//  CoreDataDemo
//
//  Created by Majidov Buzurgmehr on 17/09/23.
//

import CoreData

class UserManager {
    
    private let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }

    func createUser(login: String, password: String) {
        let context = coreDataManager.context
        let user = Users(context: context)
        user.login = login
        user.password = password
        coreDataManager.saveContext()
    }

    func authUser(login: String, password: String) -> Bool {
        
        let fetchRequest: NSFetchRequest<Users> = Users.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "login = %@ AND password = %@", login, password)
        
        do {
            let matchingUsers = try coreDataManager.context.fetch(fetchRequest)
            return !matchingUsers.isEmpty
        } catch {
            print("Failed to fetch user: \(error.localizedDescription)")
            return false
        }
    }
    
}
