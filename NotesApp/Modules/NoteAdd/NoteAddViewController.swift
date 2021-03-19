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
        setupNavigationBar()
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    // MARK: - Requests
    private func requestToSave(note: Note) {
        let request = NoteAddModels.SaveNote.Request(note: note)
        interactor?.saveNote(request)
    }

    // MARK: - Private Methods
    func setupNavigationBar() {
        navigationItem.title = "Create new note"
        navigationItem.largeTitleDisplayMode = .never
        let save = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSaveButton))
        let addPic = UIBarButtonItem(title: "Image", style: .done, target: self, action: #selector(didAddPhotoTap))
        navigationItem.rightBarButtonItems = [save, addPic]
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
            let note = CoreDataWoker.shared.createNote()
            note.title = text
            note.content = noteTextView.text
            requestToSave(note: note)
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
extension NoteAddViewController: NoteAddDisplayLogic {

}

extension NoteAddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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


