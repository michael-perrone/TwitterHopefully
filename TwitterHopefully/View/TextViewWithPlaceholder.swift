//
//  TextViewWithPlaceholder.swift
//  TwitterHopefully
//
//  Created by Michael Perrone on 5/6/20.
//  Copyright © 2020 Michael Perrone. All rights reserved.
//

import UIKit

class TextViewWithPlaceholder: UITextView {

    let placeholderLabel: UILabel = {
        let label = UILabel();
        label.text = "What's Happening?";
        label.textColor = .gray;
        return label;
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        backgroundColor = .white;
        font = UIFont.systemFont(ofSize: 18);
        isScrollEnabled = false;
        setHeight(height: 200);
        
        addSubview(placeholderLabel);
        placeholderLabel.padLeft(from: leftAnchor, num: 4);
        placeholderLabel.padTop(from: topAnchor, num: 8);
        
        NotificationCenter.default.addObserver(self, selector: #selector(handlePlaceholder), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handlePlaceholder() {
        placeholderLabel.isHidden = !text.isEmpty;
    }

}
