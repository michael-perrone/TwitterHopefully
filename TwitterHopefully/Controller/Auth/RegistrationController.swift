//
//  RegistrationController.swift
//  TwitterHopefully
//
//  Created by Michael Perrone on 3/29/20.
//  Copyright © 2020 Michael Perrone. All rights reserved.
//

import UIKit
import Firebase

class RegistrationController: UIViewController {
    
    private let imagePicker = UIImagePickerController();
    private var profileImage: UIImage?
    
    let addPhotoButton: UIButton = {
        let addPhotoB = UIButton(type: .system);
        addPhotoB.setImage(UIImage(named: "plus_photo"), for: .normal);
        addPhotoB.tintColor = .white;
        addPhotoB.addTarget(self, action: #selector(handleAddPhoto), for: .touchUpInside)
        return addPhotoB;
    }()

    let registerbutton: UIButton = {
        let registerB = UIButton(type: .system)
        registerB.setTitle("Register", for: .normal)
        registerB.heightAnchor.constraint(equalToConstant: 60).isActive = true;
        registerB.backgroundColor = .white;
        registerB.layer.cornerRadius = 6;
        registerB.setTitleColor(.systemPink, for: .normal)
        registerB.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        registerB.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        return registerB;
    }()
    
    
    lazy var emailInputView: UIView = {
        let uiView = Utilities().inputContainerView(withImage: #imageLiteral(resourceName: "ic_mail_outline_white_2x-1"), text: emailTextField)
        return uiView;
    }()
    
    let emailTextField: UITextField = {
        let text = UITextField()
        text.textColor = .white;
        text.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        return text;
    }()
    
    lazy var passwordInputView: UIView = {
        let uiView = Utilities().inputContainerView(withImage: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), text: passwordTextField)
        return uiView
    }()
    
    let passwordTextField: UITextField = {
        let text = UITextField()
        text.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        text.isSecureTextEntry = true;
        return text;
    }()
    
    lazy var passwordConfirmView: UIView = {
        let uiView = Utilities().inputContainerView(withImage: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), text: passwordConfirmText)
        return uiView
    }()
    
    let passwordConfirmText: UITextField = {
        let text = UITextField()
        text.attributedPlaceholder = NSAttributedString(string: "Re-enter Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        text.isSecureTextEntry = true;
        return text;
    }()
    
    
    lazy var nameInputViewContainer: UIView = {
        let uiView = Utilities().inputContainerView(withImage: #imageLiteral(resourceName: "ic_person_outline_white_2x"), text: nameTextField)
        return uiView;
    }()
    
    let nameTextField: UITextField = {
        let text = UITextField();
        text.placeholder = "Full Name";
        text.textColor = .white;
        text.attributedPlaceholder = NSAttributedString(string: "Full Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        return text;
    }()
    
    
    let backToLoginButton: UIButton = {
        let backButton = Utilities().attributedButton("Need to Login? ", "Go Back")
        backButton.addTarget(self, action: #selector(headBackToLogin), for: .touchUpInside)
        return backButton;
    }()
    
    // MARK: - Selectors
    
    @objc func headBackToLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleRegister() {
        guard let profileImage = profileImage else {
            print("no image")
            return};
        guard let email = emailTextField.text else {return};
        guard let password = passwordTextField.text else {return};
        guard let fullName = nameTextField.text else {return};
        
        
        let credentials = AuthCredentials(email: email, password: password, fullName: fullName, profileImage: profileImage)
        
        AuthService.shared.registerUser(credentials: credentials) { (error, ref) in
            guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
            
            guard let tab = window.rootViewController as? TabBarViewController else {return}
            
            tab.authenticateUser()
            
            self.dismiss(animated: true, completion: nil);
        }
    }
    
    @objc func handleAddPhoto() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    func configUI() {
        view.backgroundColor = .systemPink;
        imagePicker.delegate = self;
        imagePicker.allowsEditing = true;
        view.addSubview(addPhotoButton);
        addPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 10);
        addPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true;
        addPhotoButton.heightAnchor.constraint(equalToConstant: 100).isActive = true;
        addPhotoButton.widthAnchor.constraint(equalToConstant: 100).isActive = true;
        view.addSubview(backToLoginButton)
        backToLoginButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 40, paddingBottom: 10, paddingRight: 40)
        
        
        let stack = UIStackView(arrangedSubviews: [nameInputViewContainer, emailInputView, passwordInputView, passwordConfirmView, registerbutton])
        view.addSubview(stack);
        stack.anchor(top: addPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30, paddingLeft: 0.075 * view.frame.size.width, paddingRight: 0.075 * view.frame.size.width, width: view.frame.size.width / 1.15, height: 350)
        stack.axis = .vertical;
        stack.distribution = .equalCentering;
        
    }
}
// MARK: - UIImagePickerDelegate

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else {return}
        self.profileImage = profileImage;
        addPhotoButton.layer.cornerRadius = 50;
        addPhotoButton.layer.masksToBounds = true;
        addPhotoButton.imageView?.contentMode = .scaleAspectFill;
        addPhotoButton.imageView?.clipsToBounds = true;
        addPhotoButton.layer.borderColor = UIColor.white.cgColor;
        addPhotoButton.layer.borderWidth = 2.0;
        self.addPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        dismiss(animated: true, completion: nil)
    }
}
