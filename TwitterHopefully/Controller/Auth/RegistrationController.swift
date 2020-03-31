//
//  RegistrationController.swift
//  TwitterHopefully
//
//  Created by Michael Perrone on 3/29/20.
//  Copyright © 2020 Michael Perrone. All rights reserved.
//

import UIKit

class RegistrationController: UIViewController {
    
    private let imagePicker = UIImagePickerController();
    
    let addPhotoButton: UIButton = {
        let addPhotoB = UIButton(type: .system);
        addPhotoB.setImage(UIImage(named: "plus_photo"), for: .normal);
        addPhotoB.tintColor = .white;
        addPhotoB.addTarget(self, action: #selector(handleAddPhoto), for: .touchUpInside)
        addPhotoB.heightAnchor.constraint(equalToConstant: 140).isActive = true;
        addPhotoB.widthAnchor.constraint(equalToConstant: 60).isActive = true;
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
        print("registering")
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
        addPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 5, paddingLeft: 30, paddingRight: 30, width: 20)
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
        addPhotoButton.layer.cornerRadius = 70;
        addPhotoButton.layer.masksToBounds = true;
        addPhotoButton.imageView?.contentMode = .scaleAspectFill;
        addPhotoButton.imageView?.clipsToBounds = true;
        addPhotoButton.layer.borderColor = UIColor.white.cgColor;
        self.addPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        dismiss(animated: true, completion: nil)
    }
}
