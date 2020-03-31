//
//  FeedController.swift
//  TwitterHopefully
//
//  Created by Michael Perrone on 3/29/20.
//  Copyright © 2020 Michael Perrone. All rights reserved.
//

import UIKit

class FeedController: UIViewController {
    
    // PROPS
    
    
    // LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    

 
    // HELPERS
    
    func configureUI() {
         view.backgroundColor = .white;
         let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
         imageView.contentMode = .scaleAspectFit;
         navigationItem.titleView = imageView;
     }
    
}
