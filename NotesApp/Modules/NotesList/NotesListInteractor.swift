//
//  NotesListInteractor.swift
//  NotesApp
//
//  Created by Vladimir Udachin on 16.03.2021.
//

import Foundation

protocol NotesListBusinessLogic {
    func fetchNotesList(_ request: NotesListModels.FetchNotesList.Request)
    func editSelectedNote(_ request: NotesListModels.EditNote.Request)
}

protocol NotesListDataStore {
    var selectedNote: Note? { get }
}

final class NotesListInteractor: NotesListBusinessLogic, NotesListDataStore {

    // MARK: - Public Properties
    var presenter: NotesListPresentationLogic?
    lazy var worker: NotesListWorkingLogic = NotesListWorker()

    // MARK: - Private Properties
    var notesList = [Note]()
    var selectedNote: Note?
    // MARK: - Business Logic
    func fetchNotesList(_ request: NotesListModels.FetchNotesList.Request) {
        worker.fetchNotesFromLocalDataStore { (result) in
            switch result {
            case .success(let notes):
                self.notesList = notes
                let response = NotesListModels.FetchNotesList.Response(notes: notes)
                self.presenter?.presentFetchedNotesList(response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func editSelectedNote(_ request: NotesListModels.EditNote.Request) {
        guard !notesList.isEmpty, request.index < notesList.count else {
             return
         }
         selectedNote = notesList[request.index]
     }
}
