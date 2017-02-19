//
//  CountryInfoVC.swift
//  PlugLife
//
//  Created by Adam McRae on 2017-01-14.
//  Copyright © 2017 Adam McRae. All rights reserved.
//

import UIKit

class CountryInfoVC: UIViewController {
    var country: Country!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        country.basecurrencyConvert {
            print("Arrived Here")

        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
