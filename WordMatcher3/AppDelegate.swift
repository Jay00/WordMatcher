//
//  AppDelegate.swift
//  WordMatcher3
//
//  Created by Jason Clark on 3/10/15.
//  Copyright (c) 2015 Jason Clark. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy var coreDataStack = CoreDataStack()


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        

        
        
        let navigationController = self.window!.rootViewController as UINavigationController
        let viewController = navigationController.topViewController as ViewController
        
        
       
        let documentsURL = applicationDocumentsDirectory()
        let storeURL = documentsURL.URLByAppendingPathComponent("WordMatcher")
        
        var manager = NSFileManager()
        if !manager.fileExistsAtPath(storeURL.path!){
            
            //Grab File
            var bundle = NSBundle.mainBundle()
            var url = bundle.URLForResource("listOfWords", withExtension: "txt")
            var myString = NSString(contentsOfURL: url!, encoding: NSUTF16StringEncoding , error: nil)
            
            var array = myString?.componentsSeparatedByString("\n") as [String]
            
            for word in array {
                println("The \(word) was saved!")
                let wordEntity = NSEntityDescription.entityForName("Entity", inManagedObjectContext: coreDataStack.context)
                
                let newWord = Entity(entity: wordEntity!, insertIntoManagedObjectContext: coreDataStack.context)
                
                newWord.theWord = word
               
                
                coreDataStack.saveContext()
                
                println("\(word) was save!")
                viewController.coreDataStack = coreDataStack
            }
            
        } else {
            println("The store is already present")
            viewController.coreDataStack = coreDataStack
        }

     
        return true
    }
    
    
    func applicationDocumentsDirectory() -> NSURL {
        let fileManager = NSFileManager.defaultManager()
        
        let urls = fileManager.URLsForDirectory(.DocumentDirectory,
            inDomains: .UserDomainMask) as [NSURL]
        
        return urls[0]
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
    }


}

