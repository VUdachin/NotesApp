//
//  CoreDataWorker.swift
//  NotesApp
//
//  Created by Vladimir Udachin on 17.03.2021.
//
import Foundation
import CoreData

class CoreDataWoker {
    static let shared = CoreDataWoker()

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NotesApp")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                context.rollback()
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func deleteContext(object: NSManagedObject) {
        context.delete(object)
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                context.rollback()
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
