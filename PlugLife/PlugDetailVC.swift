//
//  PlugDetailVC.swift
//  PlugLife
//
//  Created by Adam McRae on 2017-01-19.
//  Copyright © 2017 Adam McRae. All rights reserved.
//

import UIKit

class PlugDetailVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    @IBAction func moreInfo(_ sender: Any) {
        //self.removeAnimate()
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
    

    //var imagepath: String = ""
    
    
    var stringPassed = Plug(plugType: "A")
    // var pluginfo = Plug()
    
    
    override func viewDidLoad() {
        //print(stringPassed)

        
        self.showAnimate()
        super.viewDidLoad()
        plugImageGallery.dataSource = self
        plugImageGallery.delegate = self
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        //self.scrapeIEC()
        

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
            
            
            imagepath = stringPassed.plugImageList[indexPath.row]
            
            cell.configureCell(plug: imagepath)
            
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
    
    

    

    

    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
