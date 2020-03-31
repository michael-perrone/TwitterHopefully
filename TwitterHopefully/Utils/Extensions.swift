//
//  Extensions.swift
//  TwitterHopefully
//
//  Created by Michael Perrone on 3/29/20.
//  Copyright © 2020 Michael Perrone. All rights reserved.
//

import UIKit

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil
    ) {
        
        translatesAutoresizingMaskIntoConstraints = false;
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true;
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true;
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true;
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true;
        }
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true;
        }
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true;
        }
    }
    
    func anchorLeft(left: NSLayoutXAxisAnchor, paddingLeft: CGFloat) {
        leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true;
    }
    
    func anchorTop(top: NSLayoutYAxisAnchor, paddingTop: CGFloat) {
        topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true;
    }
    func anchorRight(right: NSLayoutXAxisAnchor, paddingRight: CGFloat) {
        rightAnchor.constraint(equalTo: right, constant: paddingRight).isActive = true;
    }
    func anchorBottom(bottom: NSLayoutYAxisAnchor, paddingBottom: CGFloat) {
        bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true;
    }
    
}






extension UIImage {
  func resizeImage(targetSize: CGSize) -> UIImage {
    let size = self.size
    let widthRatio  = targetSize.width  / size.width
    let heightRatio = targetSize.height / size.height
    let newSize = widthRatio > heightRatio ?  CGSize(width: size.width * heightRatio, height: size.height * heightRatio) : CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
    let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    self.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return newImage!
  }
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1);
    }
}
