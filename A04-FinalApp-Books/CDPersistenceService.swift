//
//  CDPersistenceService.swift
//  A04-FinalApp-Books
//
//  Created by Olivia Sartorius Freschet on 21/2/20.
//  Copyright © 2020 Olivia Sartorius Freschet. All rights reserved.
//

import Foundation
import CoreData

//we create this class to not have the AppDelegate filled with Core Data Stack code
class CDPersistenceService {
    
    //1.
    private init() {}
    static var context: NSManagedObjectContext { return persistentContainer.viewContext }
    
    //-------------
    /* MARK: - Core Data stack - the first file that executes as soon as app is launched
                                - we can save and fetch the context the from the Core Data Stack.*/
    //2. changed from lazy to static
    static var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */                                    //3. changed "A04_FinalApp_Books" to:
        let container = NSPersistentContainer(name: "A04_FinalApp_Books")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                //4. changed 'fatalError()' (causes app to generate a crash log and terminate) to:
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
                //5. add a return type Bool
    static func saveContext () -> Bool {
        let context = CDPersistenceService.persistentContainer.viewContext //TODO: why do I need to instantiate?
        if context.hasChanges {
            do {
                try context.save()
                //
                return true
            } catch {
                let nserror = error as NSError
                //same as 4.
                print("Unresolved error \(nserror), \(nserror.userInfo)")
                //
                return false
            }
            //
        }else{
            return false
        }
    }
    
    // MARK: - Core Data Delete Codes       TODO: utility?
    
    static func deleteAllCodesRecords() {
        let context = persistentContainer.viewContext
        
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
            print("CD:fetch request deleted")
        } catch {
            print ("There was an error")
        }
    }
    
    //Fetch form Core Data
    static func fetchFromCoreData() -> Bool {
        let context = persistentContainer.viewContext
        var resss:Bool = false
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            
            for data in result as! [NSManagedObject] {
                print("fetched form core data:",data.value(forKey: "email") as! String)
                resss=true
            }
        } catch {
            print("Failed")
        }
        print(resss)
        return resss
    }

}
