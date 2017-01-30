//
//  PlugDetailVC.swift
//  PlugLife
//
//  Created by Adam McRae on 2017-01-19.
//  Copyright © 2017 Adam McRae. All rights reserved.
//

import UIKit

protocol PlugDetailVCDelegate {
    func plugDetailVCSelectCountry(value: Country)
}

class PlugDetailVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource {
    
    var delegate : PlugDetailVCDelegate?
    
    @IBOutlet weak var plugTypeLabel2: UILabel!
    @IBOutlet weak var plugTypeLabel: UILabel!
    @IBOutlet weak var groundedLabel: UILabel!
    @IBOutlet weak var numPinsLabel: UILabel!
    @IBOutlet weak var ampRatingLabel: UILabel!
    @IBOutlet weak var compatLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBAction func selector(_ sender: Any) {
        if segmentedControl.selectedSegmentIndex == 0 {
            galleryView.isHidden = false
            moreInfoView.isHidden = true
        } else {
            galleryView.isHidden = true
            moreInfoView.isHidden = false
        }
       
        
    }
    @IBOutlet weak var galleryView: UIView!
    @IBOutlet weak var moreInfoView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var plugInfo: UITextView!
    
    var country = countrylist[0]
    var filteredCountries = [Country]()
    
    @IBAction func moreInfo(_ sender: Any) {
  
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "plugPopUp") as! PopUpViewController
        popOverVC.stringPassed = self.stringPassed
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }
    @IBAction func closePopUp(_ sender: Any) {
        self.removeAnimate()
    }
    
    
    @IBOutlet weak var plugImage: UIImageView!
    @IBOutlet weak var plugImageGallery: UICollectionView!
    @IBOutlet weak var popView: UIView!
    


    
    
    var stringPassed = Plug(plugType: "A") //Initiating variable to be passed from CountryDetailVC

    
    
    override func viewDidLoad() {
        
        plugImage.layer.borderWidth = 3
        plugImage.layer.borderColor = UIColor.black.cgColor
        plugImage.layer.cornerRadius = 4
        plugImage.clipsToBounds = true


        filteredCountries = countrylist.filter({$0.plugType.range(of: stringPassed.plugType) != nil})
        self.showAnimate()
        super.viewDidLoad()
        plugImageGallery.dataSource = self
        plugImageGallery.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        var compattext = "Socket compatible with plug types"
        for types in stringPassed.compatiblePlugs {
            if String(types.characters.prefix(1)) != "?" {
            compattext += " \(types)"
            }
        }
        plugTypeLabel.text = "Plug Type: \(stringPassed.plugType)"
        compatLabel.text = compattext
        ampRatingLabel.text = "Amp Rating: \(String(stringPassed.ampRating))"
        numPinsLabel.text = "Number of Pins: \(String(stringPassed.numPins))"
        if stringPassed.grounded {
            groundedLabel.text = "Grounded"
            
        }else {
            groundedLabel.text = "Not Grounded"
        }
        
        plugImage.image = UIImage(named: stringPassed.plugImageList[0])
        plugTypeLabel2.text = "Type: \(stringPassed.plugType)"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.plugInfo.text = typeInfo["\(stringPassed.plugType)"]
        popView.layer.borderWidth = 4
        popView.layer.borderColor = UIColor.black.cgColor
        popView.layer.cornerRadius = 4
        popView.clipsToBounds = true

    }
    
    
    func showAnimate() {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: { self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate() {
        UIView.animate(withDuration: 0.25, animations: { self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool) in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlugDetailCell", for: indexPath) as? PlugDetailCell {
            let imagepath: String!
            let nameText: String!
            
            
            imagepath = stringPassed.plugImageList[indexPath.row]
            nameText = stringPassed.plugImageNameList[indexPath.row]
            
            cell.configureCell(plug: imagepath, name: nameText)
            
            return cell
        } else {
            return UICollectionViewCell()
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        plugImage.image = UIImage(named: stringPassed.plugImageList[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return stringPassed.plugImageList.count
        
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 66, height: 77)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.delegate?.plugDetailVCSelectCountry(value: filteredCountries[indexPath.row])
        self.removeAnimate()
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
