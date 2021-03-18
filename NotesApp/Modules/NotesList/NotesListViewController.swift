//
//  NotesListViewController.swift
//  NotesApp
//
//  Created by Vladimir Udachin on 16.03.2021.
//

import UIKit

protocol NotesListDisplayLogic: AnyObject {
    func displayFetchedNotesList(_ viewModel: NotesListModels.FetchNotesList.ViewModel)
}

final class NotesListViewController: UIViewController {

    // MARK: - UI Outlets
    @IBOutlet private weak var noNotesLabel: UILabel!
    @IBOutlet private weak var notesTableView: UITableView!
  
    // MARK: - Public Properties

    var interactor: NotesListBusinessLogic?
    var router: (NotesListRoutingLogic & NotesListDataPassing)?

    // MARK: - Private Properties
    var notes: [Note]?
    
    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        NotesListConfigurator.shared.configure(self)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        requestToFetchNotesList()
    }

    // MARK: - Public Methods


    // MARK: - Requests
    private func requestToFetchNotesList() {
        let request = NotesListModels.FetchNotesList.Request()
        interactor?.fetchNotesList(request)
    }
    
    private func requestToSelectNotes(by index: Int) {
        let request = NotesListModels.EditNote.Request(index: index)
        interactor?.editSelectedNote(request)
    }

    // MARK: - Private Methods
    private func setupTableView() {
//        notesTableView.isHidden = true
        notesTableView.delegate = self
        notesTableView.dataSource = self
    }
  
    // MARK: - UI Actions

    @IBAction func didTapAddButton(_ sender: Any) {
        router?.routeToNoteAdd()
        print("button tapped")
    }
    
}

// MARK: - Display Logic
extension NotesListViewController: NotesListDisplayLogic {
    func displayFetchedNotesList(_ viewModel: NotesListModels.FetchNotesList.ViewModel) {
        self.notes = viewModel.notes
        DispatchQueue.main.async {
            self.notesTableView.reloadData()
        }
    }
}

extension NotesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard let cell = notesTableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as? NoteCell,
              let note = notes?[indexPath.row] else {
            fatalError("Could not init NoteCell")
        }
        cell.configure(note: note)
        return cell
    }
    
    
}

extension NotesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        notesTableView.deselectRow(at: indexPath, animated: true)
        requestToSelectNotes(by: indexPath.row)
        router?.routeToNoteEditor()
    }
}
