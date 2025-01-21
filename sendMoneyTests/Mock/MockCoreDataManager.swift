//
//  MockCoreDataManager.swift
//  sendMoneyTests
//
//  Created by Ahmed Ezz on 21/01/2025.
//
import CoreData

@testable import sendMoney

class MockCoreDataManager: CoreDataProcotol {
    
    private lazy var mockContainer = createMockContainer()
    
    func fetchContext() -> NSManagedObjectContext {
        return mockContainer?.viewContext ?? .init(concurrencyType: .mainQueueConcurrencyType)
    }

    func saveData(context: NSManagedObjectContext, onComplete: ((Bool) -> Void)) {
        do {
            try context.save()
            onComplete(true)
        } catch (let error) {
            print("CoreDataSaveError:\(error)")
            onComplete(false)
        }
    }
    
    func fetchData<T>(request: NSFetchRequest<T>, onComplete: (([NSManagedObject]?) -> Void)) where T : NSManagedObject {
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

private extension MockCoreDataManager {
    
    func createMockContainer() -> NSPersistentContainer? {
        let container = NSPersistentContainer(name: "sendMoney")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]
        
        container.loadPersistentStores { _, error in
            
        }
        return container
    }
}
