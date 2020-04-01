//
//  TabBarViewController.swift
//  TwitterHopefully
//
//  Created by Michael Perrone on 3/29/20.
//  Copyright © 2020 Michael Perrone. All rights reserved.
//

import UIKit
import Firebase

class TabBarViewController: UITabBarController {
    
    // PROPS
    
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white;
        button.backgroundColor = UIColor(red: 0, green: 0.5, blue: 1, alpha: 0.5)
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        button.layer.cornerRadius = 56 / 2;
        button.addTarget(self, action: #selector(willCreateThis), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - API
    
    func authenticateUser() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen;
                self.present(nav, animated: true, completion: nil)
            }
            print("DEBUG: not logged in")
        } else {
            print ("DEBUG: logged in")
            configureViewContollers()
            configureUI()
        }
    }
    
    func signout() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print("debug: faield to signout with error \(error.localizedDescription)")
            
        }
    }
    
    // LIFECYCLE
    

    override func viewDidLoad() {
        super.viewDidLoad()
        authenticateUser()
       
    }
    
    // HELPERS

    @objc func willCreateThis() {
        print(actionButton.frame)
    }
    
    
    
    func configureUI() {
        view.addSubview(actionButton)
        actionButton.translatesAutoresizingMaskIntoConstraints = false;
        actionButton.heightAnchor.constraint(equalToConstant: 56).isActive = true;
        actionButton.widthAnchor.constraint(equalToConstant: 56).isActive = true;
        actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -64).isActive = true;
        actionButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -24).isActive = true;
        
    
    }
    
    func configureViewContollers() {
        viewControllers = [
            templateNavController(image: UIImage(named: "home_unselected"), rootViewController: FeedController()),
            templateNavController(image: UIImage(named: "search_unselected"), rootViewController: ExploreController()),
            templateNavController(image: UIImage(named: "like_unselected"), rootViewController: NotificationsController()),
            templateNavController(image: UIImage(named: "ic_mail_outline_white_2x-1"), rootViewController: ConversationsController())
        ];
    }
    
    func templateNavController(image: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        let navItem = UINavigationController(rootViewController: rootViewController);
        navItem.tabBarItem.image = image;
        navItem.navigationBar.barTintColor = .white;
        return navItem;
    }


}
