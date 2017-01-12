//
//  CountryDetailVC.swift
//  PlugLife
//
//  Created by Adam McRae on 2017-01-11.
//  Copyright © 2017 Adam McRae. All rights reserved.
//

import UIKit

class CountryDetailVC: UIViewController {
    var country: Country!

    @IBOutlet weak var nameLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLbl.text = country.name
        

        // Do any additional setup after loading the view.
    }



}
