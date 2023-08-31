//
//  UserSroty+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by Majidov Buzurgmehr on 31/08/23.
//
//

import Foundation
import CoreData


extension UserSroty {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserSroty> {
        return NSFetchRequest<UserSroty>(entityName: "UserSroty")
    }

    @NSManaged public var title: String?
    @NSManaged public var titleDescription: String?
    @NSManaged public var status: String?

}

extension UserSroty : Identifiable {

}
