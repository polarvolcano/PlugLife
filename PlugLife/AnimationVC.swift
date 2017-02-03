//
//  AnimationVC.swift
//  PlugLife
//
//  Created by Adam McRae on 2017-01-15.
//  Copyright © 2017 Adam McRae. All rights reserved.
//

import UIKit

class AnimationVC: UIViewController {
    var logoImage: [UIImage] = [
        UIImage(named: "B2")!,
        UIImage(named: "C2")!,
        UIImage(named: "G2")!,
        UIImage(named: "I2")!
    ]
    
    @IBOutlet weak var plugLifetxt: UILabel!
    @IBOutlet weak var glasses: UIImageView!
    @IBOutlet weak var centreImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        //self.glasses.center.x += view.bounds.width
        self.plugLifetxt.center.y -= view.bounds.height
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        self.centreImage.animationImages = logoImage;
        self.centreImage.animationRepeatCount = 1
        self.centreImage.animationDuration = 2
        self.centreImage.startAnimating()
        UIView.animate(withDuration: 1, delay: 2, animations: {
        //    self.centreImage.image = UIImage(named: "C2")
                        //self.glasses.center.x -= self.view.bounds.width
                        self.plugLifetxt.center.y += self.view.bounds.height
        }, completion: { finished in
            self.performSegue(withIdentifier: "startSegue", sender: self)
        })
        
        
 
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
