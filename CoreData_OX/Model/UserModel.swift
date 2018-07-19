//
//  UserModel.swift
//  CoreData_OX
//
//  Created by pushp on 7/18/18.
//  Copyright © 2018 pushp. All rights reserved.
//

import Foundation

class UserModel {
    var fname: String?
    var lname: String?
    var id: Date
    var profilePicPath: String?
    
    init(fname: String, lname: String, profilePicPath: String, id: Date) {
        self.fname = fname
        self.lname = lname
        self.profilePicPath = profilePicPath
        self.id = id
    }
}
