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
    
    func createNote() -> Note {
        let note = NSEntityDescription.insertNewObject(forEntityName: "Note", into: context) as! Note
        return note
    }
    
    func createFirstStartNote() {
        let note = createNote()
        note.title = "Welcome"
        note.content = "Tap plus and create new note"
        saveContext()
        
    }

}
