//
//  NoteEditorInteractor.swift
//  NotesApp
//
//  Created by Vladimir Udachin on 16.03.2021.
//

import Foundation

protocol NoteEditorBusinessLogic {

}

protocol NoteEditorDataStore {

}

final class NoteEditorInteractor: NoteEditorBusinessLogic, NoteEditorDataStore {

    // MARK: - Public Properties

    var presenter: NoteEditorPresentationLogic?
    lazy var worker: NoteEditorWorkingLogic = NoteEditorWorker()

    // MARK: - Private Properties

    // MARK: - Business Logic

}
