//
//  NoteEditorModels.swift
//  NotesApp
//
//  Created by Vladimir Udachin on 16.03.2021.
//

import UIKit

enum NoteEditorModels {
  
    // MARK: - Something
    enum FetchNote {
        struct Request {}
    
        struct Response {
            let note: Note
        }
    
        struct ViewModel {
            let note: Note
        }
    }
    
    enum SaveChanges {
        struct Request {
            let title: String
            let content: String
        }
    }
}
