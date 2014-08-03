//
//  AppDelegate.swift
//  Chirper
//
//  Created by Mihir Kelkar on 8/2/14.
//  Copyright (c) 2014 Mihir Kelkar. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        //  ********** TUTORIAL SECOND ELEMENT HERE ***************
        //We got rid of all of prexisting code since we are gong to build the app using story board.
        //We will add some custom parse registration code here.
        Parse.setApplicationId("prsoUlSJCZWGdDj9g7gbxM1s2pkgvY6niAW2S8lI", clientKey: "GFeQOA9iSoJPL2yElEo294Mjc0xumIBAJbGvtVRU")
        /*[Parse setApplicationId:@"prsoUlSJCZWGdDj9g7gbxM1s2pkgvY6niAW2S8lI"
        clientKey:@"GFeQOA9iSoJPL2yElEo294Mjc0xumIBAJbGvtVRU"];*/
        
        

        //Copy the SDK Code from the Parse website and translating it into swift. This was to test if the 
        //code for SDK Worked.
        /*
        var testObject: PFObject = PFObject(className : "TestObject")
        testObject["foo"] = "bar"
        testObject.setObject("user1", forKey: "user1")
        testObject.saveInBackground()
        */
        //This is the SDK Code from the parse website. Lets translate this into swift code.
        /*PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
        testObject[@"foo"] = @"bar";
        [testObject saveInBackground];
        */
        
        //  ************  TUTORIAL THIRD ELEMENT WILL BE BUILDING THE APP IN THE STORYBOARD. *******
        // I will write a desctipyion of the story board build right here. 
        //Go ahead and get a new story board. 
        //Create a table view controller. First. 
        //Now click on the table view that you just determined and embed in a navigation controller. 
        //Now in the original table view. Enlarge the prototype cell by enlarging it. 
        //Add two labels and a text view to the cell. 
        //Now add a bar button item on the top and make it an add button by changing its identifier. 
        //Now add a view controller to the storyboard. 
        //Drag a control from the add button to the new view contoller and select push as segue 
        //between both the view controller.
        //To the newly defined view. Add a text View which will be used to add our chirps. A charecter count and a done buton which we will press to send our chirps. 
        //Now lets define a new class called Timeline to display our chirps which is a subclass of UITableViewController. Connect out table view controller to the class that we just defined.
        //Similarly define a create Chirps class which is a subclass of UIViewController and connect the view controller to it
        //Continued in the createChirpsclass. 

        //The original code has been commented out here
        
        /*self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        // Override point for customization after application launch.
        self.window!.backgroundColor = UIColor.whiteColor()
        self.window!.makeKeyAndVisible()
        return true */
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    func saveContext () {
        var error: NSError? = nil
        let managedObjectContext = self.managedObjectContext
        if managedObjectContext != nil {
            if managedObjectContext.hasChanges && !managedObjectContext.save(&error) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                //println("Unresolved error \(error), \(error.userInfo)")
                abort()
            }
        }
    }

    // #pragma mark - Core Data stack

    // Returns the managed object context for the application.
    // If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
    var managedObjectContext: NSManagedObjectContext {
        if !_managedObjectContext {
            let coordinator = self.persistentStoreCoordinator
            if coordinator != nil {
                _managedObjectContext = NSManagedObjectContext()
                _managedObjectContext!.persistentStoreCoordinator = coordinator
            }
        }
        return _managedObjectContext!
    }
    var _managedObjectContext: NSManagedObjectContext? = nil

    // Returns the managed object model for the application.
    // If the model doesn't already exist, it is created from the application's model.
    var managedObjectModel: NSManagedObjectModel {
        if !_managedObjectModel {
            let modelURL = NSBundle.mainBundle().URLForResource("Chirper", withExtension: "momd")
            _managedObjectModel = NSManagedObjectModel(contentsOfURL: modelURL)
        }
        return _managedObjectModel!
    }
    var _managedObjectModel: NSManagedObjectModel? = nil

    // Returns the persistent store coordinator for the application.
    // If the coordinator doesn't already exist, it is created and the application's store added to it.
    var persistentStoreCoordinator: NSPersistentStoreCoordinator {
        if !_persistentStoreCoordinator {
            let storeURL = self.applicationDocumentsDirectory.URLByAppendingPathComponent("Chirper.sqlite")
            var error: NSError? = nil
            _persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
            if _persistentStoreCoordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil, error: &error) == nil {
                /*
                Replace this implementation with code to handle the error appropriately.

                abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                Typical reasons for an error here include:
                * The persistent store is not accessible;
                * The schema for the persistent store is incompatible with current managed object model.
                Check the error message to determine what the actual problem was.


                If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.

                If you encounter schema incompatibility errors during development, you can reduce their frequency by:
                * Simply deleting the existing store:
                NSFileManager.defaultManager().removeItemAtURL(storeURL, error: nil)

                * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
                [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true}

                Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.

                */
                //println("Unresolved error \(error), \(error.userInfo)")
                abort()
            }
        }
        return _persistentStoreCoordinator!
    }
    var _persistentStoreCoordinator: NSPersistentStoreCoordinator? = nil

    // #pragma mark - Application's Documents directory
                                    
    // Returns the URL to the application's Documents directory.
    var applicationDocumentsDirectory: NSURL {
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.endIndex-1] as NSURL
    }

}

