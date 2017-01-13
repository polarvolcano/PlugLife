//
//  ViewController.swift
//  PlugLife
//
//  Created by Adam McRae on 2017-01-11.
//  Copyright © 2017 Adam McRae. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var collection: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var countries = [Country]()
    var filteredCountries = [Country]()
    var inSearchMode = false

    override func viewDidLoad() {
        super.viewDidLoad()
        collection.dataSource = self
        collection.delegate = self
        searchBar.delegate = self
        
        searchBar.returnKeyType = UIReturnKeyType.done 
        parseCountryCSV()
        // Do any additional setup after loading the view, typically from a nib.
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
                print(isoCode)
                
                let country = Country(name: name, isoCode: isoCode, plugType: plugType)
                countries.append(country)
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
                country = countries[indexPath.row]
            }
            cell.configureCell(country: country)
            
            return cell
        } else {
            return UICollectionViewCell()
        
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var country: Country!
        
        if inSearchMode {
            country = filteredCountries[indexPath.row]
        } else {
            country = countries[indexPath.row]
        }
        performSegue(withIdentifier: "CountryDetailVC", sender: country)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            return filteredCountries.count
            
        }else {
            return countries.count
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
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
            filteredCountries = countries.filter({$0.name.lowercased().range(of: lower) != nil})
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

