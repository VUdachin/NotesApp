//
//  NoteAddRouter.swift
//  NotesApp
//
//  Created by Vladimir Udachin on 16.03.2021.
//

import UIKit

protocol NoteAddRoutingLogic {
    func routeBackToNotesList()
    func showFillAlert()
    func alertForPickerController()
}

protocol NoteAddDataPassing {
    var dataStore: NoteAddDataStore? { get }
}

final class NoteAddRouter: NoteAddRoutingLogic, NoteAddDataPassing {

    // MARK: - Public Properties
    weak var viewController: NoteAddViewController?
    var dataStore: NoteAddDataStore?
  
    // MARK: - Private Methods
    private func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = viewController
        imagePicker.allowsEditing = true
        imagePicker.sourceType = sourceType
        viewController?.present(imagePicker, animated: true, completion: nil)
    }

    // MARK: - Routing Logic
    func routeBackToNotesList() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func showFillAlert() {
        let alert = UIAlertController(title: "Whooops", message: "Fill all fields", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(cancel)
        viewController?.present(alert, animated: true, completion: nil)
    }
    
    func alertForPickerController() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Photo Gallery", style: .default, handler: { (_) in
            self.showImagePickerController(sourceType: .photoLibrary)
        }))

        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
            self.showImagePickerController(sourceType: .camera)
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        viewController?.present(alert, animated: true, completion: nil)
    }
}
