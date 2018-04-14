//
//  CoreDataClass.swift
//  CoreData
//
//  Created by Killva on 3/16/18.
//  Copyright © 2018 Killva. All rights reserved.
//

import Foundation
import CoreData

class CoreDataClass {
    
    // MARK: - Core Data stack
    private init() {}
    static var context : NSManagedObjectContext {
        return CoreDataClass.persistentContainer.viewContext
    }
    
    static var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Hyper")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
  static   func saveContext () {
        let context = CoreDataClass.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("🐙Saved🐙")
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    //MARK: Delete RecentSearch
    
    static func deleteRecentSerch(searchData : RecentSearch) -> Bool {
        
        context.delete(searchData)
        
        do {
            try context.save()
            return true
            
        } catch {
            return false
        }
        
    }
    
    static func deleteFavItem(searchData : FavCD) -> Bool {
        
        context.delete(searchData)
        
        do {
            try context.save()
            return true
            
        } catch {
            return false
        }
        
    }
    static func deleteCartItem(searchData : CartCD) -> Bool {
        
        context.delete(searchData)
        
        do {
            try context.save()
            return true
            
        } catch {
            return false
        }
        
    }
    static func someEntityExistsInFavCD(id: Int)  -> FavCD? {
        let favRequest : NSFetchRequest<FavCD>  = FavCD.fetchRequest()
 
        
        do {
            
            let recnt = try CoreDataClass.context.fetch(favRequest)
 
 
            
            print(recnt.count)
            for x in recnt {
                print(x.id)
                if x.id == id {
                    return x
                }
                //                re.append(x)
            }
        } catch {
            return nil
        }
        return nil 
    }
    
    static func someEntityExistsInCartCD(id: Int)  -> CartCD? {
        let favRequest : NSFetchRequest<CartCD>  = CartCD.fetchRequest()
        
        
        do {
            
            let recnt = try CoreDataClass.context.fetch(favRequest)
            
            
            
            print(recnt.count)
            for x in recnt {
                print(x.id)
                if x.id == id {
                    return x
                }
                //                re.append(x)
            }
        } catch {
            return nil
        }
        return nil
    }
    
    static func cleanRecentSearchData() -> Bool {
        
        let delete = NSBatchDeleteRequest(fetchRequest: RecentSearch.fetchRequest())
        do {
            try context.execute(delete)
            return true
        } catch {
            return false
        }
    }
}

