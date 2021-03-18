//
//  NoteEditorPresenter.swift
//  NotesApp
//
//  Created by Vladimir Udachin on 16.03.2021.
//

import UIKit

protocol NoteEditorPresentationLogic {
    func presentFetchedNote(_ response: NoteEditorModels.FetchNote.Response)
}

final class NoteEditorPresenter: NoteEditorPresentationLogic {

    // MARK: - Public Properties

    weak var viewController: NoteEditorDisplayLogic?

    // MARK: - Private Properties

    
    // MARK: - Presentation Logic
    func presentFetchedNote(_ response: NoteEditorModels.FetchNote.Response) {
        let viewModel = NoteEditorModels.FetchNote.ViewModel(note: response.note)
        viewController?.displayFetchedNote(viewModel)
        
    }
}
