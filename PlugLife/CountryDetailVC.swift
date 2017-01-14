//
//  CountryDetailVC.swift
//  PlugLife
//
//  Created by Adam McRae on 2017-01-11.
//  Copyright © 2017 Adam McRae. All rights reserved.
//

import UIKit
import Alamofire

class CountryDetailVC: UIViewController,UIWebViewDelegate {
    var country: Country!

    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var plugImg: UIImageView!
    
    @IBOutlet weak var baseCurrency: UILabel!
    
    @IBOutlet weak var destCurrency: UILabel!
    
    @IBOutlet weak var USD: UILabel!
    
    @IBOutlet weak var destCurrency2: UILabel!
    
    override func viewDidLoad() {
        
        
        //country.currencyConvert {
          //  print("Arrived here")
           // print(baseLocale.regionCode!)
            //print(baseLocale.currencyCode!)
            //print(baseLocale.currencySymbol!)
            //self.updateUI()
       // }
        country.basecurrencyConvert {
            print("Arrived Here")
           // print(self.country.locale.currencyCode!)
        }
        super.viewDidLoad()
        nameLbl.text = country.name
        let img = UIImage(named: "\(country.isoCode.lowercased())")
        
        plugImg.image = img
        
        
        let plugs = country.plugType.components(separatedBy: "/")
        for i in 0...plugs.count-1 {
            self.addimage(plug: plugs[i])
        }
        


        // Do any additional setup after loading the view.
    }
    
    func updateUI() {
     //   baseCurrency.text = country.
    }


    @IBAction func btnPress(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBOutlet weak var stackView: UIStackView!
    
    func addimage(plug: String) {
        
        let img = UIImage(named: "\(plug)_3d_plug_m")
        let imgview = UIImageView(image: img)
        imgview.contentMode = UIViewContentMode.scaleAspectFit
        //let webView = UIWebView()
        //webView.delegate = self
        
        stackView.addArrangedSubview(imgview)
        
   
    }
    
    
}
