//
//  Note+CoreDataProperties.swift
//  NotesApp
//
//  Created by Vladimir Udachin on 17.03.2021.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var title: String?
    @NSManaged public var content: String?

}

extension Note : Identifiable {

}
