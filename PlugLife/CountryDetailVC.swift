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

class CountryDetailVC: UIViewController,UIWebViewDelegate, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource {
    var country: Country!
    var plugCompat = false
    var voltCompat = false
    var totalCompat = false
    //var sendURL = String()
    var plugarray = [Plug]()
    let length: CGFloat = 200
    
    
    

    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var plugLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var plugTypesLbl: UILabel!
    @IBOutlet weak var voltageLbl: UILabel!
    @IBOutlet weak var frequencyLbl: UILabel!
    
    @IBOutlet weak var plugImg: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBAction func showPopup(sender: UIButton) {
        print(sender.tag)
        //let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "plugPopUp") as! PopUpViewController
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "plugDetail") as! PlugDetailVC
        popOverVC.stringPassed = self.plugarray[sender.tag]
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
        
    }
    
    let currentCountry = countrylist.filter({$0.isoCode.range(of: Locale.current.regionCode!) != nil})[0]
    
    
    override func viewDidLoad() {
        
        
        
        
        scrollView.delegate = self
        

        
        super.viewDidLoad()
        nameLbl.text = country.name
        
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let voltcompare1 = Float(String(country.voltage.characters.prefix(3)))!
        let voltcompare2 = Float(String(currentCountry.voltage.characters.prefix(3)))!
        let img = UIImage(named: "\(country.isoCode.lowercased())")
        infoView.layer.borderWidth = 3
        infoView.layer.borderColor = UIColor.black.cgColor
        infoView.layer.cornerRadius = 4
        infoView.clipsToBounds = true
        
        plugImg.image = img
        plugImg.layer.borderWidth = 3
        plugImg.layer.borderColor = UIColor.black.cgColor
        plugImg.layer.cornerRadius = 4
        plugImg.clipsToBounds = true
        
        //var plugarray = [Plug]()
        let plugs = country.plugType.components(separatedBy: "/")
    
        for i in 0...plugs.count-1 {
            self.addimage(plug: plugs[i], index: i)
            self.addScrollView(plug: plugs[i], index: i)
            let plug = Plug(plugType: plugs[i])
            self.plugarray.append(plug)
            print(self.plugarray[i].iecURL)
            
            if currentCountry.plugType.range(of: plugs[i]) != nil {
                plugCompat = true
                
            }
            
            
            
        }
        
        
        
        
        if currentCountry.plugType.range(of: country.plugType) != nil {
            totalCompat = true
        }
        
        plugTypesLbl.text = country.plugType
        
        voltageLbl.text = country.voltage
        frequencyLbl.text = country.frequency
        scrollView.clipsToBounds = false
        plugLbl.text = "Plug Type \(plugarray[0].plugType)"
        
        print("\(Locale.current.regionCode)")
        
        print(currentCountry.name)
        if voltcompare1/voltcompare2 > 0.9 && voltcompare1/voltcompare2 < 1.1 {
            voltCompat = true
            print("voltage within range")
            
        }
        
        
    }
    


    @IBAction func btnPress(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBOutlet weak var stackView: UIStackView!
    
    func addScrollView(plug: String, index: Int) {
        print("Scrollview Width: \(scrollView.frame.size.width)")
        let imgview = UIImageView()
        let btn = UIButton()
        let img = UIImage(named: "\(plug)2")
        imgview.image = img
        let xposition = scrollView.frame.size.width/2 + scrollView.frame.size.width * CGFloat(index)
        btn.frame = CGRect(x: xposition - scrollView.frame.size.height/2, y: 0, width: scrollView.frame.size.height, height: scrollView.frame.size.height)
        btn.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        btn.setImage(img, for: .normal)
        btn.tag = index
        btn.addTarget(self, action: #selector(showPopup), for: UIControlEvents.touchUpInside)
        
        
        scrollView.contentSize.width = scrollView.frame.size.width * CGFloat(index+1)
        print("\(plug)2")
        //let imgview = UIImageView(image: img)
        //btn.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        //let imgview = UIImageView(image: img)
        //imgview.contentMode = UIViewContentMode.scaleAspectFit
        //let webView = UIWebView()
        //webView.delegate = self
        
        scrollView.addSubview(btn)
        
        
    }
    
    func addimage(plug: String, index: Int) {
        
        let img = UIImage(named: "\(plug)2")
        let btn = UIButton()
        btn.setImage(img, for: .normal)
       // btn.frame.size.height = 40
       // btn.frame.size.height = 40
        btn.tag = index
        btn.addTarget(self, action: #selector(showPopup), for: UIControlEvents.touchUpInside)
        btn.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        //let imgview = UIImageView(image: img)
        //imgview.contentMode = UIViewContentMode.scaleAspectFit
        //let webView = UIWebView()
        //webView.delegate = self
        
        stackView.addArrangedSubview(btn)
        
   
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPagefloat: CGFloat = floor((scrollView.contentOffset.x-scrollView.frame.size.width/2)/scrollView.frame.size.width)+1
        let currentPage = Int(currentPagefloat)
        plugLbl.text = "Plug Type \(plugarray[currentPage].plugType)"
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "countryTableCell", for: indexPath) as? CountryTableViewCell {
            
            let country = filteredCountries[indexPath.row]
            cell.configureCell(country: country)
            return cell
        }else {
            return CountryTableViewCell()
        }
        
        
    }
    
    
    
    
}
