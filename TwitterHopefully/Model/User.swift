//
//  User.swift
//  TwitterHopefully
//
//  Created by Michael Perrone on 4/30/20.
//  Copyright © 2020 Michael Perrone. All rights reserved.
//

import Foundation


struct User {
    let fullName: String;
    let email: String;
    let profileImageURL: String;
    let uid: String;
    
    init(uid: String, dictionary: [String: String]) {
        self.uid = uid;
        self.fullName = dictionary["fullName"]!;
        self.profileImageURL = dictionary["profileImageURL"]!;
        self.email = dictionary["email"]!;
    }
}
