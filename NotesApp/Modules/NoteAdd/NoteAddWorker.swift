//
//  NoteAddWorker.swift
//  NotesApp
//
//  Created by Vladimir Udachin on 16.03.2021.
//

import Foundation

protocol NoteAddWorkingLogic {
    func saveNoteInLocalDataStore(note: Note)
}

final class NoteAddWorker: NoteAddWorkingLogic {
  
    // MARK: - Private Properties
    let coreDataWorker = CoreDataWoker.shared

    // MARK: - Working Logic
    func saveNoteInLocalDataStore(note: Note) {
        coreDataWorker.saveContext()
    }
}
