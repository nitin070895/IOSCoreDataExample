//
//  CustomNSObjectViewController.swift
//  CoreDataExample
//
//  Created by Nitin Khurana on 22/02/18.
//  Copyright © 2018 Nitin Khurana. All rights reserved.
//

import UIKit
import CoreData

class CustomNSObjectViewController: UIViewController {

    @IBOutlet var userName:UITextField!
    @IBOutlet var passWord:UITextField!
    
    @IBAction func save(){
        
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context:NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let ent = NSEntityDescription.entity(forEntityName: "Users", in: context)
        var newUser = UsersCustomObject(entity: ent!, insertInto: context)
        newUser.username = userName.text
        newUser.password = passWord.text
        
        do{
            try context.save()
            print(newUser)
            print("User inserted successfully!")
        }
        catch {
            print("Error creating user")
        }
        
    }
    
    @IBAction func load(){
        
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context:NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "username = %@", userName.text!)
        
        do{
            let results:NSArray = try context.fetch(request) as NSArray
            
            if(results.count > 0){
                
                print("Total users: \(results.count)")

                for _ in results{
                    
                    let res = results[0] as! UsersCustomObject
                    userName.text = res.username
                    passWord.text = res.password
                    
                    print(res.toString())
                    res.addPrefix(prefix: "Mr. ")
                    print(res.toString())
                }
                
                print("User found successfully")
            }
            else{
                print("No users found")
            }
        }
        catch{
            print("Error loading user")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
