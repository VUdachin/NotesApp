//
//  NoteCell.swift
//  NotesApp
//
//  Created by Vladimir Udachin on 16.03.2021.
//

import UIKit

class NoteCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var notePreviewLabel: UILabel!
    

    func configure(note: Note) {
        titleLabel.text = note.title
        notePreviewLabel.text = note.content
    }

}
