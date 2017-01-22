//
//  CompatibleNotesCell.swift
//  PlugLife
//
//  Created by Adam McRae on 2017-01-21.
//  Copyright © 2017 Adam McRae. All rights reserved.
//

import UIKit

class CompatibleNotesCell: UITableViewCell {

    @IBOutlet weak var noteImage: UIImageView!
    @IBOutlet weak var noteText: UITextView!
    
    func configureCell(text: String, image: String) {
        noteText.text = text
        noteImage.image = UIImage(named: image)
    }


}
