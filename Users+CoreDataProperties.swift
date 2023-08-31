//
//  Users+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by Majidov Buzurgmehr on 30/08/23.
//
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }

    @NSManaged public var login: String?
    @NSManaged public var password: String?

}

extension Users{
    
    static func createUser(login: String, password: String) {
        let context = AppDelegate.container.viewContext
        let user = Users(context: context)
        user.login = login
        user.password = password
        
        do {
            try context.save()
        } catch {
            print("Failed to save user: \(error.localizedDescription)")
        }
    }
    
    static func authUser(login: String, password: String) -> Bool {
        let context = AppDelegate.container.viewContext
        
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
}
