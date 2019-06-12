//
//  RegisterController.swift
//  whatsong v3
//
//  Created by Tom Andrew on 20/5/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class SignUpController: UIViewController   {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
    }
    
    let signupHeading: UILabel = {
        let label = UILabel()
        label.text = "Sign Up"
        label.font = UIFont(name: "FatFrank", size: 28)
        label.textColor = .white
        return label
    }()
    
    let usernameInput: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = UIColor.brandPurple()
        tf.autocapitalizationType = .none
        tf.textColor = .white
        tf.font = UIFont(name: "Montserrat-Regular", size: 16)
        let attributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font : UIFont(name: "Montserrat-Regular", size: 16)!,
            NSAttributedString.Key.kern: -0.2
        ]
        tf.attributedPlaceholder = NSAttributedString(string: "Username", attributes: attributes)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        tf.setBottomBorder(color: .white)
        return tf
    }()
    
    let passwordInput: UITextField = {
        let tf = UITextField()
        tf.isSecureTextEntry = true
        tf.backgroundColor = UIColor.brandPurple()
        tf.textColor = .white
        tf.font = UIFont(name: "Montserrat-Regular", size: 16)
        let attributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font : UIFont(name: "Montserrat-Regular", size: 16)!,
            NSAttributedString.Key.kern: -0.2
        ]
        tf.attributedPlaceholder = NSAttributedString(string: "Password", attributes: attributes)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        tf.setBottomBorder(color: .white)
        return tf
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 243/255, green: 204/255, blue: 224/255, alpha: 1)
        button.isEnabled = false
        button.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 16)
        button.setTitle("Create Your Account", for: .normal)
        button.setTitleColor(UIColor.brandPurple(), for: .normal)
        button.layer.cornerRadius = 4
        // button.addTarget(self, action: #selector(signUpAction), for: .touchUpInside)
        return button
    }()
    
    let dismissButtonWhite: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back-icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.backgroundColor = .clear
        button.tintColor = .white
        
        button.setTitleColor(UIColor.brandDarkGrey(), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func handleTextInputChange()    {
        let isFormValid = usernameInput.text?.count ?? 0 > 2 && passwordInput.text?.count ?? 0 > 2
        
        if isFormValid {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = .white
        } else  {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = UIColor(red: 243/255, green: 204/255, blue: 224/255, alpha: 1)
            
        }
    }
    
    @objc func handleDismiss()    {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupViews() {
        
        view.backgroundColor = UIColor.brandPurple()
        
        let stackView = UIStackView(arrangedSubviews: [usernameInput, passwordInput, signUpButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.constrainHeight(constant: 160)
        stackView.spacing = 14
        
        view.addSubview(dismissButtonWhite)
        view.addSubview(signupHeading)
        view.addSubview(stackView)
        
        dismissButtonWhite.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 80, left: 20, bottom: 0, right: 0))
        signupHeading.anchor(top: dismissButtonWhite.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 20, left: 20, bottom: 0, right: 0))
        stackView.anchor(top: signupHeading.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 40, left: 20, bottom: 0, right: 20))
    }
    
}
