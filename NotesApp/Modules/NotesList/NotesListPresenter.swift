//
//  NotesListPresenter.swift
//  NotesApp
//
//  Created by Vladimir Udachin on 16.03.2021.
//

import UIKit

protocol NotesListPresentationLogic {
    func presentFetchedNotesList(_ response: NotesListModels.FetchNotesList.Response)
}

final class NotesListPresenter: NotesListPresentationLogic {

    // MARK: - Public Properties
    weak var viewController: NotesListDisplayLogic?
    
    // MARK: - Presentation Logic
    func presentFetchedNotesList(_ response: NotesListModels.FetchNotesList.Response) {
        let viewModel = NotesListModels.FetchNotesList.ViewModel(notes: response.notes)
        viewController?.displayFetchedNotesList(viewModel)
        
    }
}
