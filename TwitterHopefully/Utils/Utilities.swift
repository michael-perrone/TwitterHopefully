//
//  Utilities.swift
//  TwitterHopefully
//
//  Created by Michael Perrone on 3/30/20.
//  Copyright © 2020 Michael Perrone. All rights reserved.
//

import UIKit
import SDWebImage

class Utilities {
    func inputContainerView(withImage image: UIImage, text: UITextField) -> UIView {
        let uiView = UIView()
        uiView.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        let imageView = UIImageView()
        imageView.image = image;
        uiView.addSubview(imageView)
        imageView.anchor(left: uiView.leftAnchor, bottom: uiView.bottomAnchor, paddingLeft: 10, paddingBottom: 11)
        imageView.heightAnchor.constraint(equalToConstant: 24).isActive = true;
        imageView.widthAnchor.constraint(equalToConstant: 24).isActive = true;
        uiView.addSubview(text)
        text.anchor(left: imageView.rightAnchor, bottom: uiView.bottomAnchor, right: uiView.rightAnchor, paddingLeft: 14, paddingBottom: 10, height: 25)
        text.textColor = .white;
        let borderView = UIView()
        uiView.addSubview(borderView)
        borderView.backgroundColor = .white;
        borderView.heightAnchor.constraint(equalToConstant: 1.5).isActive = true;
        borderView.anchor(left: uiView.leftAnchor, bottom: uiView.bottomAnchor, right: uiView.rightAnchor)
        return uiView;
    }
    
    func defaultUserImage(height: CGFloat, width: CGFloat) -> UIImageView {
        let defaultImageView = UIImageView();
        defaultImageView.image = #imageLiteral(resourceName: "twitter_logo_blue");
        defaultImageView.setWidth(width: width);
        defaultImageView.setHeight(height: height);
        return defaultImageView;
    }
    
    func createProfileImage(user: User, height: CGFloat, width: CGFloat) -> UIImageView {
        let profileImageView = UIImageView();
        profileImageView.setHeight(height: height);
        profileImageView.setWidth(width: width);
        profileImageView.layer.cornerRadius = width / 2;
        profileImageView.layer.masksToBounds = true;
        guard let url = URL(string: user.profileImageURL) else {return defaultUserImage(height: 32, width: 32)}
        profileImageView.sd_setImage(with: url, completed: nil);
        return profileImageView;
    }
    
    func attributedButton(_ firstPart: String, _ secondPart: String) -> UIButton {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: firstPart, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white])
        attributedTitle.append(NSAttributedString(string: secondPart, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button;
    }
    
    
}
