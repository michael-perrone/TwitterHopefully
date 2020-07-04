//
//  UploadTweetController.swift
//  TwitterHopefully
//
//  Created by Michael Perrone on 5/2/20.
//  Copyright © 2020 Michael Perrone. All rights reserved.
//

import UIKit

class UploadTweetController: UIViewController {
    
    var user: User?;

    
    private lazy var rightBarButton: UIButton = {
        let barButton = UIButton(type: .system);
        barButton.setTitle("Tweet", for: .normal);
        barButton.backgroundColor = .darkGray;
        barButton.setTitleColor(.white, for: .normal);
        barButton.layer.cornerRadius = 16;
        barButton.setHeight(height: 32);
        barButton.setWidth(width: 64);
        barButton.addTarget(self, action: #selector(sendTweet), for: .touchUpInside)
        return barButton;
    }()
    
    lazy var profileImage: UIImageView = {
        guard let user = self.user else {return Utilities().defaultUserImage(height: 32, width: 32)}
        let uiv = Utilities().createProfileImage(user: user, height: 52, width: 52)
        return uiv;
    }()
    
  
    private let tweetTextView = TextViewWithPlaceholder();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        configureUI()
    }
        
    @objc func cancel() {
        dismiss(animated: true, completion: nil);
    }
    
    @objc func sendTweet() {
        TweetService.shared.uploadTweet(caption: tweetTextView.text) { (error, ref) in
            if let error = error {
                print(error)
            }
            else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func configureUI() {
        tweetTextView.delegate = self;
        view.backgroundColor = .white;
        navigationController?.navigationBar.barTintColor = .white;
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel));
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBarButton);
        view.addSubview(profileImage);
        profileImage.padLeft(from: view.leftAnchor, num: 20);
        profileImage.padTop(from: view.safeAreaLayoutGuide.topAnchor, num: 20);
        view.addSubview(tweetTextView);
        tweetTextView.padTop(from: view.safeAreaLayoutGuide.topAnchor, num: 20);
        tweetTextView.padLeft(from: profileImage.rightAnchor, num: 20);
        tweetTextView.setHeight(height: 100);
        tweetTextView.setWidth(width: view.frame.width / 1.6);
    }
    
    
}

extension UploadTweetController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        //300 chars restriction
        return textView.text.count + (text.count - range.length) <= 140
    }    }

