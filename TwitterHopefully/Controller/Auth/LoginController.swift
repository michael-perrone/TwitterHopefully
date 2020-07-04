//
//  File.swift
//  TwitterHopefully
//
//  Created by Michael Perrone on 3/29/20.
//  Copyright © 2020 Michael Perrone. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    // PROPS
    
    private let logoImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit;
        image.clipsToBounds = true;
        image.image = #imageLiteral(resourceName: "TwitterLogo")
        return image
    }()
    
    private lazy var emailContainerView: UIView = {
        return Utilities().inputContainerView(withImage: #imageLiteral(resourceName: "ic_mail_outline_white_2x-1"), text: emailTextfield)
    }()
    
    private lazy var passwordContainerView: UIView = {
        return Utilities().inputContainerView(withImage: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), text: passwordTextField)
    }()
    
    private let emailTextfield: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        return textField
    }()

    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.isSecureTextEntry = true;
        return textField
    }()
    
    private let loginButton: UIButton = {
        let loginB = UIButton(type: .system)
        loginB.setTitle("Log In", for: .normal)
        loginB.setTitleColor(UIColor.rgb(red: 29, green: 160, blue: 240), for: .normal)
        loginB.backgroundColor = .white;
        loginB.heightAnchor.constraint(equalToConstant: 52).isActive = true;
        loginB.layer.cornerRadius = 6;
        loginB.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        loginB.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return loginB
    }()
    
    private let dontHaveAccountButton: UIButton = {
          let button = Utilities().attributedButton("Dont have an account?", " Sign Up")
          button.addTarget(self, action: #selector(handleShowSignup), for: .touchUpInside)
          return button;
      }()
    
    
    // selectors
    
    @objc func handleShowSignup() {
        let registrationController = RegistrationController()
        navigationController?.pushViewController(registrationController, animated: true)
    }
    
    @objc func handleLogin() {
        guard let email = emailTextfield.text else {return}
        guard let password = passwordTextField.text else {return}
        
        AuthService.shared.login(email: email, password: password) { (result, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
            
            guard let tab = window.rootViewController as? TabBarViewController else {return}
            
            tab.authenticateUser()
            
            self.dismiss(animated: true, completion: nil);
        }
    }
    /////////////////////
    /////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    
    func config() {
        view.backgroundColor = UIColor.rgb(red: 29, green: 161, blue: 242)
        navigationController?.navigationBar.isHidden = true;
        navigationController?.navigationBar.barStyle = .black;
        view.addSubview(logoImage);
        logoImage.translatesAutoresizingMaskIntoConstraints = false;
        logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true;
        logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -50).isActive = true;
        logoImage.widthAnchor.constraint(equalToConstant: 150).isActive = true;
        logoImage.widthAnchor.constraint(equalToConstant: 150).isActive = true;
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton]);
        stack.axis = .vertical;
        stack.spacing = 10;
        stack.distribution = .equalCentering;
        view.addSubview(stack);
        
        stack.anchor(top: logoImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 0.075 * view.frame.size.width, paddingRight: 0.075 * view.frame.size.width, width: view.frame.size.width / 1.15, height: 200)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 40, paddingBottom: 10, paddingRight: 40)
        
    }
}
