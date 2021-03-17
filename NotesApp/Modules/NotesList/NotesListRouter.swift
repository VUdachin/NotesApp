//
//  NotesListRouter.swift
//  NotesApp
//
//  Created by Vladimir Udachin on 16.03.2021.
//

import UIKit

protocol NotesListRoutingLogic {

}

protocol NotesListDataPassing {
    var dataStore: NotesListDataStore? { get }
}

final class NotesListRouter: NotesListRoutingLogic, NotesListDataPassing {

    // MARK: - Public Properties
    weak var viewController: NotesListViewController?
    var dataStore: NotesListDataStore?
  
    // MARK: - Private Properties


    // MARK: - Routing Logic

    
    // MARK: - Navigation
  

    // MARK: - Passing data

}
