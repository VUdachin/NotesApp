//
//  NotesListWorker.swift
//  NotesApp
//
//  Created by Vladimir Udachin on 16.03.2021.
//

import Foundation

protocol NotesListWorkingLogic {
    func fetchNotesFromLocalDataStore(completion: @escaping (Result<[Note], Error>) -> Void)
}

final class NotesListWorker: NotesListWorkingLogic {
    // MARK: - Private Properties
    let coreDataWorker = CoreDataWoker.shared

    // MARK: - Working Logic
    func fetchNotesFromLocalDataStore(completion: @escaping (Result<[Note], Error>) -> Void) {
        do {
            let notes = try coreDataWorker.context.fetch(Note.fetchRequest()) as [Note]
            completion(.success(notes))
        } catch {
            completion(.failure(error))
        }
    }
}
