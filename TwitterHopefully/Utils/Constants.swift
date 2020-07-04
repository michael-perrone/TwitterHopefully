//
//  Constants.swift
//  TwitterHopefully
//
//  Created by Michael Perrone on 4/1/20.
//  Copyright © 2020 Michael Perrone. All rights reserved.
//

import Foundation
import Firebase

let DB_REF = Database.database().reference();
let REF_USERS = DB_REF.child("users");
let REF_TWEETS = DB_REF.child("tweets");

let STORAGE_REF = Storage.storage().reference();
let STORAGE_PROFILE_IMAGES = Storage.storage().reference().child("profile_images");

let USER_ID = Auth.auth().currentUser?.uid;
