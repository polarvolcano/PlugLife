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

class CountryDetailVC: UIViewController,UIWebViewDelegate, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, PlugDetailVCDelegate {
    
    var country: Country!
    var plugCompat = false
    var voltCompat = false
    var totalCompat = false
    //var sendURL = String()
    var plugarray = [Plug]()
    
    func plugDetailVCSelectCountry(value: Country) {
    // This function is triggered by a country being selected from PlugDetailVC View Controller
    // The value for 'country' is changed and the entire view is updated
        
    // Remove all existing subviews already loaded
        scrollView.subviews.forEach({ $0.removeFromSuperview() })
        stackView.subviews.forEach({ $0.removeFromSuperview() })
        stackViewWidth.constant = 0
        
        
        country = value
        loadData()
        self.tableView.reloadData()
        print(value.isoCode)
    }
    
 
    @IBOutlet weak var backbtn: UIButton!
    
    
    
    let length: CGFloat = 200
    
    @IBOutlet weak var baseCountryFlag: UIButton!
    
    @IBOutlet weak var stackViewWidth: NSLayoutConstraint!
    
    @IBAction func showBaseCountryStats(_ sender: Any) { // Tapping on the home country flag shows the stats for that country

        nameLbl.text = currentCountry.name
        let img = UIImage(named: "\(currentCountry.isoCode.lowercased())")
        plugImg.image = img
        plugTypesLbl.text = "Plug Types: \(currentCountry.plugType)"
        
        voltageLbl.text = "Voltage: \(currentCountry.voltage)"
        frequencyLbl.text = "Frequency: \(currentCountry.frequency)"
    }

    
    @IBAction func hideBaseCountryStats(_ sender: Any) {
        nameLbl.text = country.name
        let img = UIImage(named: "\(country.isoCode.lowercased())")
        plugImg.image = img
        plugTypesLbl.text = "Plug Types: \(country.plugType)"
        
        voltageLbl.text = "Voltage: \(country.voltage)"
        frequencyLbl.text = "Frequency: \(country.frequency)"
    }
    
    @IBAction func hideBaseCountryStats2(_ sender: Any) {
        nameLbl.text = country.name
        let img = UIImage(named: "\(country.isoCode.lowercased())")
        plugImg.image = img
        plugTypesLbl.text = "Plug Types: \(country.plugType)"
        
        voltageLbl.text = "Voltage: \(country.voltage)"
        frequencyLbl.text = "Frequency: \(country.frequency)"
    }
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var plugLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var plugTypesLbl: UILabel!
    @IBOutlet weak var voltageLbl: UILabel!
    @IBOutlet weak var frequencyLbl: UILabel!
    
    @IBOutlet weak var plugImg: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBAction func showPopup(sender: UIButton) {  //Launches a pop-up view which depends on the tag of the button pressed, the tag corresponds to an array of plugs, index at 'tag' is sent to the pop-up view controller
        
        print(sender.tag)
        //let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "plugPopUp") as! PopUpViewController
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "plugDetail") as! PlugDetailVC
        popOverVC.stringPassed = self.plugarray[sender.tag]
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        popOverVC.delegate = self;
        
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
        
    }
    

    
    
    
    
    override func viewDidLoad() {
        

        let img = UIImage(named: "\(currentCountry.isoCode.lowercased())")
        
        baseCountryFlag.setImage(img, for: .normal)
        baseCountryFlag.layer.borderWidth = 3
        baseCountryFlag.layer.borderColor = UIColor.black.cgColor
        baseCountryFlag.layer.cornerRadius = 4
        baseCountryFlag.clipsToBounds = true
        
        
        scrollView.delegate = self
        

        
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        backbtn.layer.borderWidth = 3
        backbtn.layer.borderColor = UIColor.black.cgColor
        backbtn.layer.cornerRadius = 4
        backbtn.clipsToBounds = true

    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {  //load all the data into the view. Using viewDidAppear due to issues with the scrollView screen bounds not being loaded if done in viewdidload
        loadData()
        
    }
    
    
    func loadData() {
        self.plugarray.removeAll()
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
        

        let plugs = country.plugType.components(separatedBy: "/")
        let homeplugs = currentCountry.plugType.components(separatedBy: "/")
        
        for i in 0...plugs.count-1 {
            self.addScrollView(plug: plugs[i], index: i)
            let plug = Plug(plugType: plugs[i])
            self.plugarray.append(plug)
            
            
            
            
        }
        
        for i in 0...homeplugs.count-1 {
            self.addimage(plug: homeplugs[i], index: (plugs.count+i))
            let plug = Plug(plugType: homeplugs[i])
            self.plugarray.append(plug)
        }
        
        
        
        
        
        
        
        
        nameLbl.text = country.name
        plugTypesLbl.text = "Plug Types: \(country.plugType)"
        
        voltageLbl.text = "Voltage: \(country.voltage)"
        frequencyLbl.text = "Frequency: \(country.frequency)"
        
        scrollView.clipsToBounds = false
        plugLbl.text = "Plug Type: \(plugarray[0].plugType)"
        
        print("\(Locale.current.regionCode)")
        
        print(currentCountry.name)
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
        scrollView.addSubview(btn)
        
        
    }
    
    func addimage(plug: String, index: Int) {
        
        let img = UIImage(named: "\(plug)2")
        let btn = UIButton()
        btn.setImage(img, for: .normal)
        btn.layer.borderWidth = 3
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.cornerRadius = 4
        btn.clipsToBounds = true

        btn.tag = index
        btn.addTarget(self, action: #selector(showPopup), for: UIControlEvents.touchUpInside)
        btn.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        stackViewWidth.constant += 44
        stackView.addArrangedSubview(btn)
        
        
   
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPagefloat: CGFloat = floor((scrollView.contentOffset.x-scrollView.frame.size.width/2)/scrollView.frame.size.width)+1
        let currentPage = Int(currentPagefloat)
        print("Plug Array Length \(plugarray.count)")
        print(currentPage)
        if plugarray.count > 0 {
            
        
        
        
        plugLbl.text = "Plug Type \(plugarray[currentPage].plugType)"
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let compatnotes = CompatNote(plug: currentCountry, socket: country)
        return compatnotes.compatType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let compatnotes = CompatNote(plug: currentCountry, socket: country)
        if let cell = tableView.dequeueReusableCell(withIdentifier: "compatibleCell", for: indexPath) as? CompatibleNotesCell {
            
            cell.configureCell(text: "\(compatnotes.infoText[indexPath.row]!)", image: "\(compatnotes.compatType[indexPath.row]!)")
            return cell

        }else {
            return CompatibleNotesCell()
        }
        
        
    }
    
    
    
    
}
