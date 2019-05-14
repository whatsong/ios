//
//  LoginController.swift
//  whatsong v3
//
//  Created by Tom Andrew on 13/5/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .green
        return iv
    }()
    
    let loginHeading: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.font = UIFont(name: "Montserrat-Regular", size: 28)
        label.textColor = UIColor.brandBlack()
        return label
    }()
    
    let usernameInput: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .white
        tf.autocapitalizationType = .none
        tf.textColor = UIColor.brandBlack()
        tf.placeholder = "Username"
        tf.borderStyle = .roundedRect
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    let passwordInput: UITextField = {
        let tf = UITextField()
        tf.isSecureTextEntry = true
        tf.backgroundColor = .white
        tf.placeholder = "Password"
        tf.borderStyle = .roundedRect
        tf.textColor = UIColor.brandBlack()
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.brandPurple()
        button.isEnabled = false
        button.setTitle("Login", for: .normal)
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    func setupViews()   {
        
        view.backgroundColor = UIColor.backgroundGrey()
        
        let stackView = UIStackView(arrangedSubviews: [usernameInput, passwordInput, loginButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.constrainHeight(constant: 160)
        stackView.spacing = 10
        
        view.addSubview(loginHeading)
        view.addSubview(stackView)
        
        loginHeading.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 100, left: 20, bottom: 0, right: 0))
        stackView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 40, right: 20))
        
    }
    
    @objc func handleTextInputChange()    {
        let isFormValid = usernameInput.text?.count ?? 0 > 2 && passwordInput.text?.count ?? 0 > 2
        
        if isFormValid {
            loginButton.isEnabled = true
            loginButton.backgroundColor = UIColor.brandPurple()
        } else  {
            loginButton.isEnabled = false
            loginButton.backgroundColor = UIColor.brandLightGrey()
        }
    }
    
    @objc func handleLogin()  {
        
        let url = URL(string: "https://www.what-song.com/api/sign-in")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let postString = [
            "login": usernameInput.text,
            "password": passwordInput.text
            ] as! [String: String]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: postString, options: .prettyPrinted)
            print(request.httpBody)
        }   catch let error {
            print("JSON error:", error.localizedDescription)
            displayAlert(userMessage: "Http body could not be set on request")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                self.displayAlert(userMessage: "Could not perform request")
                print("error: ", error)
                return
            }
            do  {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                if let parsedJson = json    {
                    print(parsedJson)
                }   else    {
                    self.displayAlert(userMessage: "JSON is empty")
                }
            } catch {
                print("Catched error is: ", error)
            }
        }
        task.resume()
        self.present(MainTabBarController(), animated: true, completion: nil)
    }
    
    func displayActivityIndicatorView() -> () {
        UIApplication.shared.beginIgnoringInteractionEvents()
        self.view.backgroundColor = UIColor(white: 1, alpha: 0.8)
        self.view.bringSubviewToFront(self.activityIndicator)
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
    }
    
    func hideActivityIndicatorView() -> () {
        if !self.activityIndicator.isHidden{
            DispatchQueue.main.async {
                UIApplication.shared.endIgnoringInteractionEvents()
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            }
        }
    }
    
    func displayAlert(userMessage: String) -> Void {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction) in
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            })
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
}
