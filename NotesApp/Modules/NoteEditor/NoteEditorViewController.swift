//
//  NoteEditorViewController.swift
//  NotesApp
//
//  Created by Vladimir Udachin on 16.03.2021.
//

import UIKit

protocol NoteEditorDisplayLogic: AnyObject {
    func displayFetchedNote(_ viewModel: NoteEditorModels.FetchNote.ViewModel)
}

final class NoteEditorViewController: UIViewController {

    // MARK: - UI Outlets
    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var noteTextView: UITextView!
    
  
    // MARK: - Public Properties
    var interactor: NoteEditorBusinessLogic?
    var router: (NoteEditorRoutingLogic & NoteEditorDataPassing)?

    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        NoteEditorConfigurator.shared.configure(self)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.becomeFirstResponder()
        titleTextField.borderStyle = .none
        navigationItem.title = "Edit note"
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save changes", style: .done, target: self, action: #selector(didTapSaveButton))
        requestToFetchNote()
    }

    // MARK: - Requests
    func requestToFetchNote() {
        let request = NoteEditorModels.FetchNote.Request()
        interactor?.fetchNote(request)
    }
    
    func requestToSaveChanges(title: String, content: String) {
        let request = NoteEditorModels.SaveChanges.Request(title: title, content: content)
        interactor?.saveChanges(request)
    }

    // MARK: - Private Methods
    private func setup() {
        let interactor = NoteEditorInteractor()
        let presenter = NoteEditorPresenter()
        let router = NoteEditorRouter()

        interactor.presenter = presenter
        presenter.viewController = self
        router.viewController = self
        router.dataStore = interactor
        
        self.interactor = interactor
        self.router = router
    }
  
    // MARK: - UI Actions
    @objc private func didTapSaveButton() {
        if let text = titleTextField.text, !text.isEmpty, !noteTextView.text.isEmpty {
            requestToSaveChanges(title: text, content: noteTextView.text)
            router?.routeBackToNotesList()
        } else {
            router?.showFillAlert()
        }
    }
}

// MARK: - Display Logic
extension NoteEditorViewController: NoteEditorDisplayLogic {
    func displayFetchedNote(_ viewModel: NoteEditorModels.FetchNote.ViewModel) {
        let note = viewModel.note
        self.titleTextField.text = note.title
        self.noteTextView.text = note.content
    }
}
