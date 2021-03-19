//
//  NoteEditorRouter.swift
//  NotesApp
//
//  Created by Vladimir Udachin on 16.03.2021.
//

import UIKit

protocol NoteEditorRoutingLogic {
    func routeBackToNotesList()
    func showFillAlert()
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
    
    func showFillAlert() {
        let alert = UIAlertController(title: "Whooops", message: "Fill all fields", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(cancel)
        viewController?.present(alert, animated: true, completion: nil)
    }
     
}
