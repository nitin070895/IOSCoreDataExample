//
//  Users.swift
//  CoreDataExample
//
//  Created by Nitin Khurana on 22/02/18.
//  Copyright © 2018 Nitin Khurana. All rights reserved.
//

import CoreData

@objc(UsersCustomObject)
class UsersCustomObject: NSManagedObject {

    @NSManaged var username:String!
    @NSManaged var password:String!
    
    func toString() -> String{
        return "Username: \(username!) password: \(password!)"
    }
    
    func addPrefix(prefix: String){
        username = prefix + username
    }
}
