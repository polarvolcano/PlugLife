//
//  CountryCell.swift
//  PlugLife
//
//  Created by Adam McRae on 2017-01-11.
//  Copyright © 2017 Adam McRae. All rights reserved.
//

import UIKit

class CountryCell: UICollectionViewCell {
    
    @IBOutlet weak var flag: UIImageView!
    @IBOutlet weak var nameLlb: UILabel!
    
    var country: Country!
    
    func configureCell(country: Country) {
        self.country = country
        
        nameLlb.text = self.country.name.capitalized
        flag.image = UIImage(named: "\(self.country.isoCode.lowercased())")
    }
    
}
