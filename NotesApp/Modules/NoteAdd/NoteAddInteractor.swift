//
//  NoteAddInteractor.swift
//  NotesApp
//
//  Created by Vladimir Udachin on 16.03.2021.
//

import Foundation

protocol NoteAddBusinessLogic {
    func saveNote(_ request: NoteAddModels.SaveNote.Request)
}

protocol NoteAddDataStore {

}

final class NoteAddInteractor: NoteAddBusinessLogic, NoteAddDataStore {

    // MARK: - Public Properties

    var presenter: NoteAddPresentationLogic?
    lazy var worker: NoteAddWorkingLogic = NoteAddWorker()

    // MARK: - Business Logic
    func saveNote(_ request: NoteAddModels.SaveNote.Request) {
        worker.saveNoteInLocalDataStore(note: request.note)
    }
}
