//
//  NoteEditorInteractor.swift
//  NotesApp
//
//  Created by Vladimir Udachin on 16.03.2021.
//

import Foundation

protocol NoteEditorBusinessLogic {
    func fetchNote(_ request: NoteEditorModels.FetchNote.Request)
    func saveChanges(_ request: NoteEditorModels.SaveChanges.Request)
}

protocol NoteEditorDataStore {
    var note: Note? { get set }
}

final class NoteEditorInteractor: NoteEditorBusinessLogic, NoteEditorDataStore {

    // MARK: - Public Properties

    var presenter: NoteEditorPresentationLogic?
    lazy var worker: NoteEditorWorkingLogic = NoteEditorWorker()

    var note: Note?

    // MARK: - Business Logic
    func fetchNote(_ request: NoteEditorModels.FetchNote.Request) {
        let response = NoteEditorModels.FetchNote.Response(note: note!)
        presenter?.presentFetchedNote(response)
    }
    
    func saveChanges(_ request: NoteEditorModels.SaveChanges.Request) {
        worker.saveNoteChangesInLocalDataStore(note: note!, changes: request)
    }
}
