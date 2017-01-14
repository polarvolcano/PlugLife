//
//  CountryDetailVC.swift
//  PlugLife
//
//  Created by Adam McRae on 2017-01-11.
//  Copyright © 2017 Adam McRae. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class CountryDetailVC: UIViewController,UIWebViewDelegate {
    var country: Country!

    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var plugImg: UIImageView!
    
    @IBOutlet weak var baseCurrency: UILabel!
    
    @IBOutlet weak var destCurrency: UILabel!
    
    @IBAction func showPopup(sender: UIButton) {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "plugPopUp") as! PopUpViewController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }
    
    
    
    override func viewDidLoad() {
        

        country.basecurrencyConvert {
            print("Arrived Here")
            self.updateUI()
            //print(self.country.locale.currencyCode!)
        }
        super.viewDidLoad()
        nameLbl.text = country.name
        let img = UIImage(named: "\(country.isoCode.lowercased())")
        
        plugImg.image = img
        
        var plugarray = [Plug]()
        let plugs = country.plugType.components(separatedBy: "/")
        for i in 0...plugs.count-1 {
            self.addimage(plug: plugs[i], index: i)
            let plug = Plug(plugType: plugs[i])
            plugarray.append(plug)
            print(plugarray[i].iecURL)
        }
        
        

        // Do any additional setup after loading the view.
    }
    
   
    
    func updateUI() {
        print(country.basexchangeRate)
        print(country.currencyCode)
        //print(country.xchangeRate)
        
        baseCurrency.text = "1 CAD"
        destCurrency.text = "\(country.basexchangeRate) \(country.currencyCode)"
       // USD.text = "1 USD"
       // destCurrency2.text = "\(country.xchangeRate) \(country.currencyCode)"
    }


    @IBAction func btnPress(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBOutlet weak var stackView: UIStackView!
    
    func addimage(plug: String, index: Int) {
        
        let img = UIImage(named: "\(plug)_3d_plug_m")
        let btn = UIButton()
        btn.setImage(img, for: .normal)
        btn.tag = index
        btn.addTarget(self, action: #selector(showPopup), for: UIControlEvents.touchUpInside)
        btn.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        //let imgview = UIImageView(image: img)
        //imgview.contentMode = UIViewContentMode.scaleAspectFit
        //let webView = UIWebView()
        //webView.delegate = self
        
        stackView.addArrangedSubview(btn)
        
   
    }
    
    
}
