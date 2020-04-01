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

let STORE_REF = Storage.storage().reference();
let STORE_PROFILE_IMAGES = Storage.storage().reference().child("profile_images");
