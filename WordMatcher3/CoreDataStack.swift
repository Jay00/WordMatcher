// Jason Clark

import CoreData

class CoreDataStack {
    
  let context:NSManagedObjectContext
  let psc:NSPersistentStoreCoordinator
  let model:NSManagedObjectModel
  let store:NSPersistentStore?
    
    var numSaves = 0

  init() {
    //1
    
    let bundle = NSBundle.mainBundle()
        println("Retrieved Main Bundle: \(bundle.description)")
    let modelURL = bundle.URLForResource("WordModel", withExtension:"momd")
    model = NSManagedObjectModel(contentsOfURL: modelURL!)!
    
    //2
    psc = NSPersistentStoreCoordinator(managedObjectModel:model)
    
    //3
    context = NSManagedObjectContext()
    context.persistentStoreCoordinator = psc
    
    //4
    let documentsURL = applicationDocumentsDirectory()
    let storeURL = documentsURL.URLByAppendingPathComponent("WordMatcher")
    
    // Check if Store Exhists
//        var manager = NSFileManager()
//    if !manager.fileExistsAtPath(storeURL.path!){
//        // Add the SQLite Files
//        let sqliteWordMatcherURL = NSBundle.mainBundle().URLForResource("WordMatcher", withExtension: "sqlite") as NSURL?
//        
//
//        let sqliteWordMatchershmURL = NSBundle.mainBundle().URLForResource("WordMatcher-shm", withExtension: "sqlite") as NSURL?
//
//        let sqliteWordMatcherwalURL = NSBundle.mainBundle().URLForResource("WordMatcher-wal", withExtension: "sqlite") as NSURL?
//
//        let arrayOfURL = [sqliteWordMatcherURL, sqliteWordMatchershmURL, sqliteWordMatcherwalURL]
//
//            for urlOpt in arrayOfURL {
//                
//                if let url = urlOpt {
//                    if !manager.fileExistsAtPath(url.pathExtension!){
//                        println("No file found for URL!!!\(url)")
//                    } else {
//                    println("Moving \(url) to the document store")
//                    var error: NSError?
//                        manager.moveItemAtURL(url, toURL: documentsURL, error: &error)
//                    }
//                    
//                } else {
//                    println("There was no url found")
//                }
//                
//            }
//
//
//        } else {
//            println("The store is already present")
//        }
    
    println("The STORE URL: \(documentsURL)")
    
    //DELETE
//    var manager = NSFileManager()
//    manager.removeItemAtURL(storeURL, error: nil)

    let options =
    [NSMigratePersistentStoresAutomaticallyOption: true]
    
    var error: NSError? = nil
    store = psc.addPersistentStoreWithType(NSSQLiteStoreType,
      configuration: nil,
      URL: storeURL,
      options: options,
      error:&error)
    
    if store == nil {
      println("Error adding persistent store: \(error)")
      abort()
    }
    
  }
  
    
  func saveContext() {
    numSaves++
    println("SAVED #\(numSaves)")
    
    var error: NSError? = nil
    if context.hasChanges && !context.save(&error) {
      println("Could not save: \(error), \(error?.userInfo)")
    }
  }
    

  func applicationDocumentsDirectory() -> NSURL {
    let fileManager = NSFileManager.defaultManager()
    
    let urls = fileManager.URLsForDirectory(.DocumentDirectory,
      inDomains: .UserDomainMask) as [NSURL]
    
    return urls[0]
  }
  
}













