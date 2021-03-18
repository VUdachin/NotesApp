//
//  NotesListModels.swift
//  NotesApp
//
//  Created by Vladimir Udachin on 16.03.2021.
//

import UIKit

enum NotesListModels {
  
    enum FetchNotesList {
        struct Request {}
    
        struct Response {
            let notes: [Note]
        }
    
        struct ViewModel {
            let notes: [Note]
        }
    }
    
    enum EditNote {
        struct Request {
            let index: Int
        }
    }
}
