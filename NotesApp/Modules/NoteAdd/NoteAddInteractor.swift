//
//  NoteAddInteractor.swift
//  NotesApp
//
//  Created by Vladimir Udachin on 16.03.2021.
//

import Foundation

protocol NoteAddBusinessLogic {

}

protocol NoteAddDataStore {

}

final class NoteAddInteractor: NoteAddBusinessLogic, NoteAddDataStore {

    // MARK: - Public Properties

    var presenter: NoteAddPresentationLogic?
    lazy var worker: NoteAddWorkingLogic = NoteAddWorker()

    // MARK: - Private Properties

    // MARK: - Business Logic

}
