//
//  PlugDetailCell.swift
//  PlugLife
//
//  Created by Adam McRae on 2017-01-19.
//  Copyright © 2017 Adam McRae. All rights reserved.
//

import UIKit

class PlugDetailCell: UICollectionViewCell {
    
    @IBOutlet weak var plugImage: UIImageView!
    @IBOutlet weak var plugImageLabel: UILabel!
   
    
    var plug: String!
    
    func configureCell(plug: String!) {
        self.plug = plug
        
        plugImageLabel.text = self.plug.capitalized
        plugImage.image = UIImage(named: "\(self.plug.lowercased())")
        plugImage.layer.borderWidth = 3
        plugImage.layer.borderColor = UIColor.black.cgColor
        plugImage.layer.cornerRadius = 4
        plugImage.clipsToBounds = true
    }
    
}
