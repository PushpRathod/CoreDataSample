//
//  ViewController.swift
//  CoreData_OX
//
//  Created by pushp on 7/18/18.
//  Copyright © 2018 pushp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(DBManager.sharedInstance.getDatabasePath())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveObject(_ sender: UIButton) {
        let userObject = UserModel(fname: "first", lname: "last", profilePicPath: "none", id: Date.init())
        DBManager.sharedInstance.saveObject(objectModel: userObject)
        print(DBManager.sharedInstance.getAllObjects().first)
        if DBManager.sharedInstance.getAllObjects().count > 0 {
           DBManager.sharedInstance.editObject(objectModel: DBManager.sharedInstance.getAllObjects().first!)
        }
        
    }
    
}

