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
            result.profilePicPath = saveImage(image: #imageLiteral(resourceName: "01-Splash-Screen.jpg"))
            result.id = objectModel.id as NSDate
            try managedContext.save()
            print(result)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func saveImage(image: UIImage) -> String{
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        // choose a name for your image
        let fileName = "\(getUpdatedID())" + ".jpg"
        // create the destination file url to save your image
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        // get your UIImage jpeg data representation and check if the destination file url already exists
        if let data = UIImageJPEGRepresentation(image, 1.0),
            !FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                // writes the image data to disk
                try data.write(to: fileURL)
                print("file saved")
                return fileURL.lastPathComponent
            } catch {
                print("error saving file:", error)
            }
        }
        return fileURL.lastPathComponent
    }
    
    func getImage(id: String) -> UIImage {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let path:String = documentsDirectory.appendingPathComponent(id).absoluteString
        let image = try! UIImage(data: Data(contentsOf: URL(fileURLWithPath: path)))
        return image!
    }
    
    func getUpdatedID() -> Int {
        var int = UserDefaults.standard.integer(forKey: "Unique")
        int = int + 1
        UserDefaults.standard.set(int, forKey: "Unique")
        return UserDefaults.standard.integer(forKey: "Unique")
    }
    
    
    
    
}
