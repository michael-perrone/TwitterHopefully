//
//  AuthService.swift
//  TwitterHopefully
//
//  Created by Michael Perrone on 4/1/20.
//  Copyright © 2020 Michael Perrone. All rights reserved.
//

import UIKit
import Firebase

struct AuthCredentials {
    let email: String
    let password: String
    let fullName: String
    let profImage: UIImage
}


struct AuthService {
    static let shared = AuthService()
    func registerUser(credentials: AuthCredentials, completion: @escaping(Error?, DatabaseReference) -> Void) {
        guard let imageData = credentials.profImage.jpegData(compressionQuality: 0.3) else {return}
              
              let fileName = NSUUID().uuidString;
              let storageRef = STORE_PROFILE_IMAGES.child(fileName);
              
              storageRef.putData(imageData, metadata: nil) { (meta, error) in
                  storageRef.downloadURL { (url, error) in
                      guard let profileImageUrl = url?.absoluteString else {return}
                      print("am i here")
                    Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
                          if let error = error {
                              print("The error is \(error)")
                              return
                          }
                          guard let uid = result?.user.uid else {return}
                          let values = ["email": credentials.email, "fullName": credentials.fullName, "profileImageUrl": profileImageUrl]
                        REF_USERS.child(uid).updateChildValues(values, withCompletionBlock: completion)
                      }
                      
                  }
        }
    }
}
