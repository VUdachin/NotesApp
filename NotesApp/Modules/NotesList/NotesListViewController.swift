//
//  NotesListViewController.swift
//  NotesApp
//
//  Created by Vladimir Udachin on 16.03.2021.
//

import UIKit

protocol NotesListDisplayLogic: AnyObject {

}

final class NotesListViewController: UIViewController {

    // MARK: - UI Outlets
    @IBOutlet private weak var noNotesLabel: UILabel!
    @IBOutlet private weak var notesTableView: UITableView!
  
    // MARK: - Public Properties

    var interactor: NotesListBusinessLogic?
    var router: (NotesListRoutingLogic & NotesListDataPassing)?

    // MARK: - Private Properties
    let notes: [Note] = []
    
    // MARK: - Init
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//        setup()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setup()
//    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        NotesListConfigurator.createScene()
    }

    // MARK: - Public Methods


    // MARK: - Requests


    // MARK: - Private Methods
    private func setupTableView() {
        notesTableView.isHidden = true
        notesTableView.delegate = self
        notesTableView.dataSource = self
    }
  
    // MARK: - UI Actions

    
}

// MARK: - Display Logic

extension NotesListViewController: NotesListDisplayLogic {

}

extension NotesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let note = notes[indexPath.row]
        
        guard let cell = notesTableView.dequeueReusableCell(withIdentifier: NoteCell.reuseIdentifier, for: indexPath) as? NoteCell else {
            fatalError("Could not init NoteCell")
        }
        cell.configure(note: note)
        return cell
    }
    
    
}

extension NotesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        notesTableView.deselectRow(at: indexPath, animated: true)
        
    }
}
