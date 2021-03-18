//
//  NoteAddRouter.swift
//  NotesApp
//
//  Created by Vladimir Udachin on 16.03.2021.
//

import UIKit

protocol NoteAddRoutingLogic {
    func routeBackToNotesList()
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
    
    // MARK: - Navigation
  

    // MARK: - Passing data

}
