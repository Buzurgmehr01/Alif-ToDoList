//
//  Task2+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by Majidov Buzurgmehr on 24/08/23.
//
//

import Foundation
import CoreData


extension Task2 {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task2> {
        return NSFetchRequest<Task2>(entityName: "Task2")
    }

    @NSManaged public var taskToDo: String?

}

extension Task2 : Identifiable {

}
