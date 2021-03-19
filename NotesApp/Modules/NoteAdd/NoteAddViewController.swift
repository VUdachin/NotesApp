//
//  NoteAddViewController.swift
//  NotesApp
//
//  Created by Vladimir Udachin on 16.03.2021.
//

import UIKit

protocol NoteAddDisplayLogic: AnyObject {

}

final class NoteAddViewController: UIViewController {

    // MARK: - UI Outlets
    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var noteTextView: UITextView!
    
    // MARK: - Public Properties

    var interactor: NoteAddBusinessLogic?
    var router: (NoteAddRoutingLogic & NoteAddDataPassing)?
    // MARK: - Private Properties

    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        NoteAddConfigurator.shared.configure(self)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.becomeFirstResponder()
        titleTextField.borderStyle = .none
        navigationItem.title = "Create new note"
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save note", style: .done, target: self, action: #selector(didTapSaveButton))
    }

    // MARK: - Requests
    private func requestToSave(note: Note) {
        let request = NoteAddModels.SaveNote.Request(note: note)
        interactor?.saveNote(request)
    }

    // MARK: - Private Methods
  
    // MARK: - UI Actions
    @objc private func didTapSaveButton() {
        if let text = titleTextField.text, !text.isEmpty, !noteTextView.text.isEmpty {
            let note = CoreDataWoker.shared.createNote()
            note.title = text
            note.content = noteTextView.text
            requestToSave(note: note)
            router?.routeBackToNotesList()
        } else {
            router?.showFillAlert()
        }
    }
    
}

// MARK: - Display Logic
extension NoteAddViewController: NoteAddDisplayLogic {

}
