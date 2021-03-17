//
//  NotesListInteractor.swift
//  NotesApp
//
//  Created by Vladimir Udachin on 16.03.2021.
//

import Foundation

protocol NotesListBusinessLogic {

}

protocol NotesListDataStore {

}

final class NotesListInteractor: NotesListBusinessLogic, NotesListDataStore {

    // MARK: - Public Properties

    var presenter: NotesListPresentationLogic?
    lazy var worker: NotesListWorkingLogic = NotesListWorker()

    // MARK: - Private Properties

    // MARK: - Business Logic

}
