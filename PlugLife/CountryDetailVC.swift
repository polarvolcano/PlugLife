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

class CountryDetailVC: UIViewController,UIWebViewDelegate, UIScrollViewDelegate {
    var country: Country!
    //var sendURL = String()
    var plugarray = [Plug]()
    let length: CGFloat = 200
    
    @IBOutlet weak var plugLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var plugRealImg: UIImageView!
    
    @IBOutlet weak var plugImg: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBAction func showPopup(sender: UIButton) {
        print(sender.tag)
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "plugPopUp") as! PopUpViewController
        popOverVC.stringPassed = self.plugarray[sender.tag]
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }
    
    
    
    override func viewDidLoad() {
        
        scrollView.delegate = self
        

        
        super.viewDidLoad()
        nameLbl.text = country.name
        
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let img = UIImage(named: "\(country.isoCode.lowercased())")
        
        plugImg.image = img
        
        //var plugarray = [Plug]()
        let plugs = country.plugType.components(separatedBy: "/")
        for i in 0...plugs.count-1 {
            self.addimage(plug: plugs[i], index: i)
            self.addScrollView(plug: plugs[i], index: i)
            let plug = Plug(plugType: plugs[i])
            self.plugarray.append(plug)
            print(self.plugarray[i].iecURL)
            
        }
        scrollView.clipsToBounds = false
        plugLbl.text = "Plug Type \(plugarray[0].plugType)"
        plugRealImg.image = UIImage(named: "\(plugarray[0].plugType)plug")
    }


    @IBAction func btnPress(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBOutlet weak var stackView: UIStackView!
    
    func addScrollView(plug: String, index: Int) {
        print("Scrollview Width: \(scrollView.frame.size.width)")
        let imgview = UIImageView()
        let btn = UIButton()
        let img = UIImage(named: "\(plug)")
        imgview.image = img
        let xposition = scrollView.frame.size.width/2 + scrollView.frame.size.width * CGFloat(index)
        btn.frame = CGRect(x: xposition - scrollView.frame.size.height/2, y: 0, width: scrollView.frame.size.height, height: scrollView.frame.size.height)
        btn.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        btn.setImage(img, for: .normal)
        btn.tag = index
        btn.addTarget(self, action: #selector(showPopup), for: UIControlEvents.touchUpInside)
        
        
        scrollView.contentSize.width = scrollView.frame.size.width * CGFloat(index+1)
        print("\(plug)")
        //let imgview = UIImageView(image: img)
        //btn.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        //let imgview = UIImageView(image: img)
        //imgview.contentMode = UIViewContentMode.scaleAspectFit
        //let webView = UIWebView()
        //webView.delegate = self
        
        scrollView.addSubview(btn)
        
        
    }
    
    func addimage(plug: String, index: Int) {
        
        let img = UIImage(named: "\(plug)")
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPagefloat: CGFloat = floor((scrollView.contentOffset.x-scrollView.frame.size.width/2)/scrollView.frame.size.width)+1
        let currentPage = Int(currentPagefloat)
        plugLbl.text = "Plug Type \(plugarray[currentPage].plugType)"
        plugRealImg.image = UIImage(named: "\(plugarray[currentPage].plugType)plug")
    }
    
    
}
