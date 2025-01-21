//
//  CoreDataManager.swift
//  sendMoney
//
//  Created by Ahmed Ezz on 20/01/2025.
//
import CoreData
import UIKit

protocol CoreDataProcotol: AnyObject {
    func saveData(context: NSManagedObjectContext, onComplete: ((Bool)-> Void))
    func fetchData<T: NSManagedObject>(request: NSFetchRequest<T>, onComplete: (([NSManagedObject]?)-> Void))
    func fetchContext() -> NSManagedObjectContext
}

class CoreDataManager: CoreDataProcotol {
    func fetchContext() -> NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    func saveData(context: NSManagedObjectContext, onComplete: ((Bool)-> Void)) {
        do {
            try context.save()
            onComplete(true)
        } catch (let error) {
            print("CoreDataSaveError:\(error)")
            onComplete(false)
        }
    }
    
    func fetchData<T: NSManagedObject>(request: NSFetchRequest<T>, onComplete: (([NSManagedObject]?)-> Void)) {
        do {
            let context = fetchContext()
            let items = try context.fetch(request)
            onComplete(items)
        } catch (let error) {
            print("CoreDataFetchError:\(error)")
            onComplete(nil)
        }
    }
}
