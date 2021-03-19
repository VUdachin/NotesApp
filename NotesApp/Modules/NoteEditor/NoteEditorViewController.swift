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
        setupNavigationBar()
        requestToFetchNote()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
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
    func setupNavigationBar() {
        navigationItem.title = "Edit note"
        navigationItem.largeTitleDisplayMode = .never
        let save = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSaveButton))
        let addPic = UIBarButtonItem(title: "Image", style: .done, target: self, action: #selector(didAddPhotoTap))
        navigationItem.rightBarButtonItems = [save, addPic]
    }
    
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
    
    @objc private func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            noteTextView.contentInset = .zero
        } else {
            noteTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }

        noteTextView.scrollIndicatorInsets = noteTextView.contentInset

        let selectedRange = noteTextView.selectedRange
        noteTextView.scrollRangeToVisible(selectedRange)
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
    
    @objc private func didAddPhotoTap() {
        router?.alertForPickerController()
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

extension NoteEditorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        let attachment = NSTextAttachment()
        attachment.image = image
        
        let newImageWidth = (noteTextView.bounds.size.width - 20 )
        
        let scale = newImageWidth/image.size.width
        let newImageHeight = image.size.height * scale

        attachment.bounds = CGRect.init(x: 0, y: 0, width: newImageWidth, height: newImageHeight)
 
        let attString = NSAttributedString(attachment: attachment)

        noteTextView.textStorage.insert(attString, at: noteTextView.selectedRange.location)
        picker.dismiss(animated: true, completion: nil)
    }
}
