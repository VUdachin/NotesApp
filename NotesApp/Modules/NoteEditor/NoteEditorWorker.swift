//
//  NoteEditorWorker.swift
//  NotesApp
//
//  Created by Vladimir Udachin on 16.03.2021.
//

import Foundation

protocol NoteEditorWorkingLogic {
    func saveNoteChangesInLocalDataStore(note: Note, changes: NoteEditorModels.SaveChanges.Request)
}

final class NoteEditorWorker: NoteEditorWorkingLogic {
  
    // MARK: - Private Properties
    let coreDataWorker = CoreDataWoker.shared

    // MARK: - Working Logic
    func saveNoteChangesInLocalDataStore(note: Note, changes: NoteEditorModels.SaveChanges.Request) {
        note.title = changes.title
        note.content = changes.content
        coreDataWorker.saveContext()
    }
}
