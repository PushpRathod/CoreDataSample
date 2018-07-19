//
//  User+CoreDataProperties.swift
//  CoreData_OX
//
//  Created by pushp on 7/18/18.
//  Copyright © 2018 pushp. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var fname: String?
    @NSManaged public var lname: String?
    @NSManaged public var profilePicPath: String?
    @NSManaged public var id: NSDate?

}
