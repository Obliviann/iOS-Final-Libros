//
//  CDPersistenceService.swift
//  A04-FinalApp-Books
//
//  Created by Olivia Sartorius Freschet on 21/2/20.
//  Copyright © 2020 Olivia Sartorius Freschet. All rights reserved.
//

import Foundation
import CoreData

/*Core Data is used to be persistent, to save data throughtout app launches, for offline use, to chache temp data... It is a framework to manage the MODEL LAYER object in our app*/

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
         */                                    //3. should change to "Data Model"?
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
    
    //Fetch form Core Data
    static func fetchFromCoreData() -> Bool {
        let context = persistentContainer.viewContext               //same as*
        var resss:Bool = false
        //Prepare the request of type NSFetchRequest for the entity
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            //Fetch the result from context in the form of array of [NSManagedObject]
            let result = try context.fetch(request)
            //Iterate through array to get value for the specific key
            for data in result as! [NSManagedObject] {
                print("fetched form CD:",data.value(forKey: "email") as! String)
                resss=true
            }
        } catch {
            print("Failed")
        }
        return resss
    }
    
    static func saveOnCoreData(email:String) {
        //CD1. we refer to the container set up in AppDelegate
        //let appDel = UIApplication.shared.delegate as! AppDelegate
        //CD2. we create a context from this container
        //let context = appDel.persistentContainer.viewContext
        //CD3. create an Entity (given the one-'Users'- we've just created in the Data Model)
        //let entity = NSEntityDescription.entity(forEntityName: "Users", in: context)
        //NO NEED TO DO THE PREVIOUS SINCE CONTAINTER ISN'T IN APPDELEGATE ANYMORE, its in:
        
        //CDPersistenceService.deleteAllCodesRecords()          -- TODO: not necessary right?
        //create new 'users' record
        let users = Users(context: CDPersistenceService.context)
        //Set values for the records for each key
        users.setValue(email, forKey: "email")
        print("CD:value ",email," saved")
        if !CDPersistenceService.saveContext(){                 //TODO: is this correct?
            print("data not saved")
        }
    }
    
    //we change username Oli to newName etc
    static func updateCoreData(){
        let context = CDPersistenceService.context              //*same as
        //Prepare the request of type NSFetchRequest for the entity
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        //we use predicate to filter data
        fetchReq.predicate = NSPredicate(format: "username = %@", "Oli")
        do {
            let test = try context.fetch(fetchReq)
            let objUpdate = test[0] as! NSManagedObject
            objUpdate.setValue("newName", forKey: "username")
            objUpdate.setValue("newmail", forKey: "email")
            do { try context.save() }
            catch { print(error) }
        }catch{
            print(error)
        }
    }
    
    // MARK: - Core Data Saving support
    //called on AD's appWillTerminate and on method above. Added Bool type
    static func saveContext () -> Bool{
        var res:Bool = false
        let context = CDPersistenceService.persistentContainer.viewContext //TODO: why do I need to instantiate?
        if context.hasChanges {
            do {
                try context.save()
                res = true
            } catch {
                let nserror = error as NSError
                //same as 4.
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        return res
    }
    
    // MARK: - Core Data Delete Codes       TODO: utility?
    static func deleteAllCodesRecords() {
        let context = persistentContainer.viewContext
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchReq)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
            print("CD:fetch request deleted")
            /*vs. ??
            let test = try context.fetch(fetchReq)
            let objToDel = test[0] as! NSManagedObject
            context.delete(objToDel)
            do { try context.save() }
            catch { print(error) }*/
        } catch {
            print ("Error deleting fetch req")
        }
    }

}
