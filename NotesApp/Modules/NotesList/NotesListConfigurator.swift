//
//  NotesListConfigurator.swift
//  NotesApp
//
//  Created by Vladimir Udachin on 16.03.2021.
//

import Foundation

class NotesListConfigurator {
    static func createScene() {
        let viewController = NotesListViewController()
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
