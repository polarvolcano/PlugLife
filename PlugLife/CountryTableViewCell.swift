//
//  CountryTableViewCell.swift
//  PlugLife
//
//  Created by Adam McRae on 2017-01-14.
//  Copyright © 2017 Adam McRae. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    @IBOutlet weak var flag: UIImageView!
    @IBOutlet weak var countryName: UILabel!
    

    
   
    
    func configureCell(country: Country) {
        countryName.text = "\(country.name)"
        flag.image = UIImage(named:country.isoCode.lowercased())
    }

}
