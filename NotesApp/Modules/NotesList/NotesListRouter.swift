//
//  NotesListRouter.swift
//  NotesApp
//
//  Created by Vladimir Udachin on 16.03.2021.
//

import UIKit

protocol NotesListRoutingLogic {
    func routeToNoteEditor()
    func routeToNoteAdd()
}

protocol NotesListDataPassing {
    var dataStore: NotesListDataStore? { get }
}

final class NotesListRouter: NotesListRoutingLogic, NotesListDataPassing {

    // MARK: - Public Properties
    weak var viewController: NotesListViewController?
    var dataStore: NotesListDataStore?
  
    // MARK: - Private Properties

    // MARK: - Routing Logic
    func routeToNoteEditor() {
        guard
            let viewController = viewController,
            let storyboard = viewController.storyboard,
            let noteEditorVC = storyboard.instantiateViewController(withIdentifier: "NoteEditor") as? NoteEditorViewController,
            var noteEditorDS = noteEditorVC.router?.dataStore else {
            fatalError("Fail route to NoteEditor")
        }
        passDataToNoteEditor(destination: &noteEditorDS)
        navigateToNoteEditor(destination: noteEditorVC)
    }

    // MARK: - Navigation
    private func navigateToNoteEditor(destination: NoteEditorViewController) {
        viewController?.navigationController?.pushViewController(destination, animated: true)
    }

    // MARK: - Passing data
    private func passDataToNoteEditor(destination: inout NoteEditorDataStore) {
        destination.note = dataStore?.selectedNote
    }
    

    func routeToNoteAdd() {
        guard
            let viewController = viewController,
            let storyboard = viewController.storyboard,
            let noteAddVC = storyboard.instantiateViewController(withIdentifier: "NoteAdd") as? NoteAddViewController,
            var noteAddDS = noteAddVC.router?.dataStore else {
            fatalError("Fail route to NoteAdd")
        }
        navigateToPetProfile(destination: noteAddVC)
    }

    // MARK: - Navigation
    private func navigateToPetProfile(destination: NoteAddViewController) {
        viewController?.navigationController?.pushViewController(destination, animated: true)
    }

}
