//
//  MainViewController.swift
//  CoreDataSwift
//
//  Created by Nicole Phelps on 7/2/14.
//  Copyright (c) 2014 Nicole Phelps. All rights reserved.
//

/* 
 * https://www.youtube.com/watch?v=3IDfgATVqHw
 * create empty application - check coredata
 * create storyboard - link to project
 * delete 4 lines from application func in AppDelegate to load storyboard
 * create viewcontroller - link to storyboard
 */

import UIKit
import CoreData

class MainViewController: UIViewController {

    @IBOutlet var txtUsername:UITextField!
    @IBOutlet var txtPassword:UITextField!
    @IBOutlet var txtSearch:UITextField!
    
    @IBAction func btnSave() {
        //println("save button pressed! \(txtUsername.text)")
        
        // sets to UI delegate cast as our AppDelegate class
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        
        //get context from AppDelegate class
        var context:NSManagedObjectContext = appDel.managedObjectContext
        
        //create object to add to db
        var newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context) as NSManagedObject
        
        // weird problem - have to append empty string first to get it to work
        newUser.setValue("" + txtUsername.text, forKey: "username");
        newUser.setValue("" + txtPassword.text, forKey: "password");
        
        //save
        context.save(nil);
        println(newUser);
        println("Object saved.")
    }
    
    @IBAction func btnLoad() {
        
        // app delegate references
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context:NSManagedObjectContext = appDel.managedObjectContext

        // create request
        var request = NSFetchRequest(entityName: "Users")
        
        // optional - prevents weird things
        request.returnsObjectsAsFaults = false
        
        // create array for load results
        var results:NSArray = context.executeFetchRequest(request, error: nil)
        
        if(results.count > 0) {
            for res in results {
                print(res)
            }
        } else {
            println("no results returned, potential error")
        }
    
    
    }
    
    @IBAction func btnSearch() {
        // app delegate references
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context:NSManagedObjectContext = appDel.managedObjectContext
        
        // create request
        var request = NSFetchRequest(entityName: "Users")
        
        // optional - prevents weird things
        request.returnsObjectsAsFaults = false
        
        request.predicate = NSPredicate(format: "username = %@", "" + txtSearch.text)
        
        
        // create array for search results
        var results:NSArray = context.executeFetchRequest(request, error: nil)
        
        if(results.count > 0) {
            
            var res = results[0] as NSManagedObject
            txtUsername.text = res.valueForKey("username") as String
            txtPassword.text = res.valueForKey("password") as String
            
            /*
            for res in results {
                println("search result: ")
                print(res)
            }
            */
        } else {
            println("no results returned, potential error")
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
    

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
