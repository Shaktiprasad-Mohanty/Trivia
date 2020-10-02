//
//  HistoryDBM.swift
//  Trivia App
//
//  Created by Shaktiprasad Mohanty on 02/10/20.
//

import Foundation
import CoreData

class HistoryDBM {
    fileprivate var mainContextInstance: NSManagedObjectContext!
    init() {
        self.mainContextInstance = appDelegate.persistentContainer.viewContext
    }
    class var shared: HistoryDBM {
        struct Singleton {
            static let instance = HistoryDBM()
        }
        
        return Singleton.instance
    }
    
    func saveData(userId:UUID,userName:String,question:String,answer:String) {
        //Minion Context worker with Private Concurrency type.
        let privateManagedObjectContext: NSManagedObjectContext =
            NSManagedObjectContext.init(concurrencyType: NSManagedObjectContextConcurrencyType.privateQueueConcurrencyType)
        privateManagedObjectContext.parent = self.mainContextInstance
        
        
            let historyObj = NSEntityDescription.insertNewObject(forEntityName: String(describing: History.self), into: privateManagedObjectContext) as! History
        historyObj.userId = userId
        historyObj.answer = answer
        historyObj.qusetion = question
        historyObj.username = userName
            saveContext(privateManagedObjectContext)
        
        saveMainContext()
        
    }
    
    func fetchUsers() ->  [History]{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: History.self))
        
        var fetchedResults = [History]()
        var users = [History]()
        var ids = [UUID]()
        do {
            fetchedResults = try self.mainContextInstance.fetch(fetchRequest) as! [History]
            print(fetchedResults)
            fetchedResults.forEach { (value) in
                if(!ids.contains(value.userId!)){
                    users.append(value)
                    ids.append(value.userId!)
                }
                
            }
            
        } catch let updateError as NSError {
            print("updateAllEventAttendees error: \(updateError.localizedDescription)")
            
        }
        return users
    }

    func fetchQuestions(userid : UUID) ->  [History]{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: History.self))
        let findByid =
            NSPredicate(format: "userId = %@", userid as CVarArg)
        fetchRequest.predicate = findByid
        var fetchedResults = [History]()
        do {
            fetchedResults = try self.mainContextInstance.fetch(fetchRequest) as! [History]
            print(fetchedResults)
            
        } catch let updateError as NSError {
            print("updateAllEventAttendees error: \(updateError.localizedDescription)")
            
        }
        return fetchedResults
    }
    
    func fetchAll() ->  [History]{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: History.self))
        var fetchedResults = [History]()
        do {
            fetchedResults = try self.mainContextInstance.fetch(fetchRequest) as! [History]
            print(fetchedResults)
            
        } catch let updateError as NSError {
            print("updateAllEventAttendees error: \(updateError.localizedDescription)")
            
        }
        return fetchedResults
    }
    
    
    
    func fetchCount() -> Int{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:String(describing: History.self))
        var count = 0
        do {
            count = try self.mainContextInstance.count(for: fetchRequest)
            return count
        }catch let fetchError as NSError {
            print("retrieveById error: \(fetchError.localizedDescription)")
            return count
        }
    }
    
    
    
    /**
     Save the  changes on the current context.
     
     - Returns: Void
     */
    func saveContext(_ context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch let saveError as NSError {
            print("save minion worker error: \(saveError.localizedDescription)")
        }
    }
    
    /**
     Save and merge the  changes on the current context with Main context.
     
     - Returns: Void
     */
    func saveMainContext() {
        do {
            try self.mainContextInstance.save()
        } catch let saveError as NSError {
            print("synWithMainContext error: \(saveError.localizedDescription)")
        }
    }
    
    
}
