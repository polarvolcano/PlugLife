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
    
    @IBOutlet weak var plugImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLbl.text = country.name
        let img = UIImage(named: "\(country.plugType)_3d_plug_m")
        
        plugImg.image = img

        // Do any additional setup after loading the view.
    }



}
