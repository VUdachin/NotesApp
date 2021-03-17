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
  
  
    // MARK: - Public Properties

    var interactor: NoteAddBusinessLogic?
    var router: (NoteAddRoutingLogic & NoteAddDataPassing)?

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
        let interactor = NoteAddInteractor()
        let presenter = NoteAddPresenter()
        let router = NoteAddRouter()

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

extension NoteAddViewController: NoteAddDisplayLogic {

}
