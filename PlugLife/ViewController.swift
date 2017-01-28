//
//  ViewController.swift
//  PlugLife
//
//  Created by Adam McRae on 2017-01-11.
//  Copyright © 2017 Adam McRae. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    var changeBaseCountrySwitch: Bool = false
    @IBAction func changeBaseCountry(_ sender: Any) {
        if changeBaseCountrySwitch == false {
            changeBaseCountrySwitch = true
            instructionLabel.text = "Select Your Base Country Below..."
            searchBar.placeholder = "Where are you travelling from?"
            baseCountryFlag.alpha = 0.4
            instructionLabel.backgroundColor = UIColor(red:0.18, green:0.56, blue:0.98, alpha:1.0)
        } else {
            changeBaseCountrySwitch = false
            instructionLabel.text = "Select Your Destination Country Below..."
            searchBar.placeholder = "What country are you going to?"
            baseCountryFlag.alpha = 1
            instructionLabel.backgroundColor = .white
        }
    }
    @IBOutlet weak var baseCountryFlag: UIButton!
    @IBOutlet weak var baseCountryLabel: UILabel!
    @IBOutlet weak var collection: UICollectionView!
    
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //var countries = [Country]()
    var filteredCountries = [Country]()
    var inSearchMode = false

    override func viewDidLoad() {
        super.viewDidLoad()
        collection.dataSource = self
        collection.delegate = self
        searchBar.delegate = self
        
        
        
        searchBar.returnKeyType = UIReturnKeyType.done 
        parseCountryCSV()
        currentCountry = countrylist.filter({$0.isoCode.range(of: baseLocale.regionCode!) != nil})[0]
        
        print(currentCountry.isoCode.lowercased())
        //baseCountryFlag.setImage(UIImage(named: "\(currentCountry.isoCode.lowercased())"), for: .normal)
        reloadCurrentCountry()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func reloadCurrentCountry() {
        baseCountryLabel.text = currentCountry.name
        var cntryimg = UIImage(named: "\(currentCountry.isoCode.lowercased())")
        baseCountryFlag.setBackgroundImage(cntryimg, for: .normal)
        baseCountryFlag.layer.borderWidth = 3
        baseCountryFlag.layer.borderColor = UIColor.black.cgColor
        baseCountryFlag.layer.cornerRadius = 4
        baseCountryFlag.clipsToBounds = true
    }
    
    
    func parseCountryCSV() {
        let path = Bundle.main.path(forResource: "country-codes", ofType: "csv")!
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            print(rows)
            
            for row in rows {
                let name = row["name"]!
                let isoCode = row["ISO3166-1-Alpha-2"]!
                let plugType = row["Plug_Types"]!
                let currencyCode = row["ISO4217-currency_alphabetic_code"]!
                let currencyName = row["ISO4217-currency_name"]!
                let voltage = row["Voltage"]!
                let frequency = row["Freq"]!
                print(isoCode)
                //print(voltage)
                //print(frequency)
                
                let country = Country(name: name, isoCode: isoCode, plugType: plugType, currencyCode: currencyCode, currencyName: currencyName, voltage: voltage, frequency: frequency)
                //countries.append(country)
                countrylist.append(country)
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CountryCell", for: indexPath) as? CountryCell {
            let country: Country!
            
            if inSearchMode {
                country = filteredCountries[indexPath.row]
            } else {
            //    country = countries[indexPath.row]
                country = countrylist[indexPath.row]
            }
            cell.configureCell(country: country)
            
            return cell
        } else {
            return UICollectionViewCell()
        
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if changeBaseCountrySwitch == true {
            
            
            if inSearchMode {
                currentCountry = filteredCountries[indexPath.row]
            } else {
                
                currentCountry = countrylist[indexPath.row]
            }
            reloadCurrentCountry()
            changeBaseCountrySwitch = false
            instructionLabel.text = "Select Your Destination Country Below..."
            searchBar.placeholder = "What country are you going to?"
            baseCountryFlag.alpha = 1
            instructionLabel.backgroundColor = .white
            
        } else {
            
        
        
        var country: Country!
        
        if inSearchMode {
            country = filteredCountries[indexPath.row]
        } else {
           // country = countries[indexPath.row]
            country = countrylist[indexPath.row]
        }
        performSegue(withIdentifier: "CountryDetailVC", sender: country)
        
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            return filteredCountries.count
            
        }else {
           // return countries.count
            return countrylist.count
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 73, height: 108)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            collection.reloadData()
            view.endEditing(true)
        } else {
            inSearchMode = true
            let lower = searchBar.text!.lowercased()
            //filteredCountries = countries.filter({$0.name.lowercased().range(of: lower) != nil})
            filteredCountries = countrylist.filter({$0.name.lowercased().range(of: lower) != nil})
            collection.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CountryDetailVC" {
            if let detailsVC = segue.destination as? CountryDetailVC {
                if let country = sender as? Country {
                    detailsVC.country = country
                }
            }
        }
    }


}



