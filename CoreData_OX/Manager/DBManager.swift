//
//  DBManager.swift
//  CoreData_OX
//
//  Created by pushp on 7/18/18.
//  Copyright © 2018 pushp. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DBManager {
    
    static let sharedInstance = DBManager()
    
    
    func getContext() -> NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    func getDatabasePath() -> String {
        let path = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true)
        return ("\(path)")
    }
    
    func saveObject(objectModel: UserModel) {
        let managedContext = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
        let user = NSManagedObject(entity: entity, insertInto: managedContext) as! User
        
        user.fname = objectModel.fname
        user.lname = objectModel.lname
        user.profilePicPath = objectModel.profilePicPath
        user.id = objectModel.id as NSDate
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func getAllObjects() -> [UserModel] {
        var people = [UserModel]()
        let managedContext = getContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        do {
          let entitiyResult = try managedContext.fetch(fetchRequest) as! [User]
             people = entitiyResult.map({ (coreDataObject) -> UserModel in
                let modelObject = UserModel(fname: coreDataObject.fname!, lname: coreDataObject.lname!, profilePicPath: coreDataObject.profilePicPath!, id: coreDataObject.id! as Date)
                return modelObject
            })
          print(people)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return people
    }
    
    func editObject(objectModel: UserModel) {
        let managedContext = getContext()
        let predicate = NSPredicate(format: "id = %@", objectModel.id as CVarArg)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        do {
            fetchRequest.predicate = predicate
            
            let result = try managedContext.fetch(fetchRequest).first as! User
            result.fname = objectModel.fname! + "Edited"
            result.lname = objectModel.lname
            result.profilePicPath = objectModel.profilePicPath
            result.id = objectModel.id as NSDate
            try managedContext.save()
            print(result)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    
    
    
}
