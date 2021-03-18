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
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    func configure(note: Note) {
        titleLabel.text = note.title
        notePreviewLabel.text = note.content
    }

}
