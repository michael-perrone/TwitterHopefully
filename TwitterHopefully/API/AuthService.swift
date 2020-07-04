

import Foundation
import UIKit
import Firebase

struct AuthCredentials {
    let email: String;
    let password: String;
    let fullName: String;
    let profileImage: UIImage;
}

struct AuthService {
    static let shared = AuthService()
    
    
    func login(email: String, password: String, completion: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func registerUser(credentials: AuthCredentials, completion: @escaping(Error?, DatabaseReference) -> Void) {
        
        guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.2) else {return}
        
        let fileName = NSUUID().uuidString;
        let storageRef = STORAGE_PROFILE_IMAGES.child(fileName);
        storageRef.putData(imageData, metadata: nil) { (meta, error) in
            storageRef.downloadURL { (url, error) in
                guard let profileImageURL = url?.absoluteString else { return }
                
                Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
                    if let error = error {
                        print("Debug: Error: \(error)")
                    }
                    
                    guard let uid = result?.user.uid else {return}
                    
                    let values = ["email": credentials.email, "fullName": credentials.fullName, "profileImageURL": profileImageURL]
                    
                    DB_REF.child("users").child(uid).updateChildValues(values, withCompletionBlock: completion)
                }
            }
        }
    }
}
