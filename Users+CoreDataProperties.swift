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
