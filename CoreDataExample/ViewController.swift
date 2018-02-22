//
//  ViewController.swift
//  CoreDataExample
//
//  Created by Nitin Khurana on 22/02/18.
//  Copyright © 2018 Nitin Khurana. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet var userName:UITextField!
    @IBOutlet var passWord:UITextField!
    
    @IBAction func save(){
     
        let appDelegate:AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let context:NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context) as NSManagedObject
        newUser.setValue("" + userName.text!, forKey: "username")
        newUser.setValue("" + passWord.text!, forKey: "password")
        
        do{
            try context.save()
            print(newUser)
            print("New User created")
        }
        catch {
            print("Error creating user")
        }
    }
    
    @IBAction func load(){
        
        let appDelegate:AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let context:NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName : "Users")
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "username = %@", "" + userName.text!)
        
        do{
            let results:NSArray = try context.fetch(request) as NSArray
            if(results.count > 0){
                
                print("Total users: \(results.count)")
                for _ in results{
                    
                    let res =  results[0] as! NSManagedObject
                    userName.text = res.value(forKey: "username") as? String
                    passWord.text = res.value(forKey: "password") as? String
                    
                }
                print("User Loaded successfully")
            }
            else{
                print("No results found")
            }
        }
        catch {
            print("Error loading User")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

