//
//  PopUpViewController.swift
//  PlugLife
//
//  Created by Adam McRae on 2017-01-13.
//  Copyright © 2017 Adam McRae. All rights reserved.
//

import UIKit
import Alamofire
import Kanna

class PopUpViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var popView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var plugInfo: UITextView!
    var country = countrylist[0]
    var filteredCountries = [Country]()
    //var filteredCountries = countrylist.filter({$0.plugType.lowercased().range(of: "A") != nil})
    
    var stringPassed = Plug(plugType: "A")
   // var pluginfo = Plug()
    

    @IBAction func closePopUp(_ sender: Any) {
        self.removeAnimate()
    }
    override func viewDidLoad() {
        //print(stringPassed)
        tableView.delegate = self
        tableView.dataSource = self
        
        self.showAnimate()
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        //self.scrapeIEC()
        
        print(country.currencyCode)
        filteredCountries = countrylist.filter({$0.plugType.range(of: stringPassed.plugType) != nil}) //stringPassed.plugType
        //tableView.reloadData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        popView.layer.borderWidth = 6
        popView.layer.borderColor = UIColor.black.cgColor
        popView.layer.cornerRadius = 4
        popView.clipsToBounds = true
        self.plugInfo.text = typeInfo["\(stringPassed.plugType)"]
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
    
    
    func scrapeIEC() {
        //print(stringPassed)
        
        Alamofire.request(self.stringPassed.iecURL).responseString { response in
            //print("\(response.result.value)")
            print(self.stringPassed)
            if let html = response.result.value {
                self.parseHTML(html: html)
            }
            
        }
    }
    
    func parseHTML(html: String) -> Void {
        if let doc = Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
            
            // Search for nodes by CSS selector
            for link in doc.css("p") {
            //    print(link.text)
            //    print(link["href"])
            }
            print(doc.css("p")[1].text!)
            print(doc.css("p")[2].text!)
            let plugtext = doc.css("p")[1].text! + doc.css("p")[2].text!
            self.plugInfo.text = plugtext
        }
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
