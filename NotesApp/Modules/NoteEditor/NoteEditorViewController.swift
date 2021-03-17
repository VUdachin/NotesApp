//
//  NoteEditorViewController.swift
//  NotesApp
//
//  Created by Vladimir Udachin on 16.03.2021.
//

import UIKit

protocol NoteEditorDisplayLogic: AnyObject {

}

final class NoteEditorViewController: UIViewController {

    // MARK: - UI Outlets
  
  
    // MARK: - Public Properties

    var interactor: NoteEditorBusinessLogic?
    var router: (NoteEditorRoutingLogic & NoteEditorDataPassing)?

    // MARK: - Private Properties

    // MARK: - Init
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    // MARK: - Public Methods


    // MARK: - Requests


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

    
}

// MARK: - Display Logic

extension NoteEditorViewController: NoteEditorDisplayLogic {

}
