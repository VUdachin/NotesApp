//
//  NoteAddConfigurator.swift
//  NotesApp
//
//  Created by Vladimir Udachin on 16.03.2021.
//

import Foundation

final class NoteAddConfigurator {
    static let shared = NoteAddConfigurator()
    
    func configure(_ control: NoteAddViewController) {
        let viewController = control
        let interactor = NoteAddInteractor()
        let presenter = NoteAddPresenter()
        let router = NoteAddRouter()

        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        viewController.interactor = interactor
        viewController.router = router
    }
}

