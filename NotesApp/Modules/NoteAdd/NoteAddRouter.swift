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
}

protocol NoteAddDataPassing {
    var dataStore: NoteAddDataStore? { get }
}

final class NoteAddRouter: NoteAddRoutingLogic, NoteAddDataPassing {

    // MARK: - Public Properties
    weak var viewController: NoteAddViewController?
    var dataStore: NoteAddDataStore?
  
    // MARK: - Private Properties


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
    // MARK: - Navigation
  

    // MARK: - Passing data

}
