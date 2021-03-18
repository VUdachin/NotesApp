//
//  NoteEditorRouter.swift
//  NotesApp
//
//  Created by Vladimir Udachin on 16.03.2021.
//

import UIKit

protocol NoteEditorRoutingLogic {
    func routeBackToNotesList()
}

protocol NoteEditorDataPassing {
    var dataStore: NoteEditorDataStore? { get }
}

final class NoteEditorRouter: NoteEditorRoutingLogic, NoteEditorDataPassing {

    // MARK: - Public Properties
    weak var viewController: NoteEditorViewController?
    var dataStore: NoteEditorDataStore?
  
    // MARK: - Private Properties


    // MARK: - Routing Logic

    func routeBackToNotesList() {
        viewController?.navigationController?.popViewController(animated: true)
    }
     
}
