//
//  NotesListConfigurator.swift
//  NotesApp
//
//  Created by Vladimir Udachin on 16.03.2021.
//

import Foundation

final class NotesListConfigurator {
    static let shared = NotesListConfigurator()
    
    func configure(_ control: NotesListViewController) {
        let viewController = control
        let interactor = NotesListInteractor()
        let presenter = NotesListPresenter()
        let router = NotesListRouter()

        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor

        viewController.interactor = interactor
        viewController.router = router
        
    }
}

