//
//  UserService.swift
//  TwitterHopefully
//
//  Created by Michael Perrone on 4/30/20.
//  Copyright © 2020 Michael Perrone. All rights reserved.
//

import Firebase

struct UserService {
    static let shared = UserService();
    
    func fetchUser(completion: @escaping(User) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        REF_USERS.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String: String] else {return}
            
            let user = User(uid: uid, dictionary: dictionary);
            
            completion(user)
        }
    }
}
