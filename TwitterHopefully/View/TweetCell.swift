//
//  TweetCell.swift
//  TwitterHopefully
//
//  Created by Michael Perrone on 5/6/20.
//  Copyright © 2020 Michael Perrone. All rights reserved.
//

import UIKit

class TweetCell: UICollectionViewCell {
    
    private let profileImage: UIImageView = {
        let iv = UIImageView();
        iv.contentMode = .scaleAspectFit;
        iv.clipsToBounds = true;
        iv.setHeight(height: 48);
        iv.setWidth(width: 48);
        iv.layer.cornerRadius = 24;
        iv.backgroundColor = .mainBlue;
        return iv;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray;
        addSubview(profileImage);
        profileImage.padLeft(from: leftAnchor, num: 10)
        profileImage.padTop(from: topAnchor, num: 2)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
