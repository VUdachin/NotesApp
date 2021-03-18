//
//  NoteEditorConfigurator.swift
//  NotesApp
//
//  Created by Vladimir Udachin on 16.03.2021.
//

import Foundation

final class NoteEditorConfigurator {
    static let shared = NoteEditorConfigurator()
    
    func configure(_ control: NoteEditorViewController) {
        let viewController = control
        let interactor = NoteEditorInteractor()
        let presenter = NoteEditorPresenter()
        let router = NoteEditorRouter()

        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        viewController.interactor = interactor
        viewController.router = router
    }
}
