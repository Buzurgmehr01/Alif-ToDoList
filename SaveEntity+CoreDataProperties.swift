//
//  SaveEntity+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by Majidov Buzurgmehr on 01/09/23.
//
//

import Foundation
import CoreData


extension SaveEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SaveEntity> {
        return NSFetchRequest<SaveEntity>(entityName: "SaveEntity")
    }

    @NSManaged public var title: String?
    @NSManaged public var taskDescription: String?

}
