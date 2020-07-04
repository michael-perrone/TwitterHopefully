//
//  FeedController.swift
//  TwitterHopefully
//
//  Created by Michael Perrone on 3/29/20.
//  Copyright © 2020 Michael Perrone. All rights reserved.
//

import UIKit


class FeedController: UICollectionViewController {
    
    var tweets: [Tweet]?
    
    var user: User? {
        didSet {
            configureLeftBarButton()
        }
    }
    
    // LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchTweets()
    }
    
    // HELPERS
    
    func configureUI() {
        
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: "TweetCell")
        collectionView.backgroundColor = .white;
         view.backgroundColor = .white;
         let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
         imageView.contentMode = .scaleAspectFit;
        imageView.setHeight(height: 44);
        imageView.setWidth(width: 44)
         navigationItem.titleView = imageView;
     }
    
    func fetchTweets() {
        TweetService.shared.fetchTweets { (tweets) in
            self.tweets = tweets;
        }
    }
    
    func configureLeftBarButton() {
        guard let user = user else {return}
        let profileImageView = Utilities().createProfileImage(user: user, height: 32, width: 32);
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView);
    }
}

    extension FeedController {
        override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 5;
        }
        
        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TweetCell", for: indexPath);
            return cell;
        }
    }

    extension FeedController: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: view.frame.width, height: 100);
        }
    }
