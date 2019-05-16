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
    let defaultSession = URLSession(configuration: .default)

    var dataTask: URLSessionDataTask?
    
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
        button.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
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
    
    @objc func loginAction() {
        handleLogin { (loginModel, error) in
            if let model = loginModel {
                DAKeychain.shared["accessToken"] = model.data.accessToken.value
                DispatchQueue.main.async {
                    self.present(MainTabBarController(), animated: true, completion: nil)
                }
            }
        }
    }
    
    func handleLogin(completion: @escaping (LoginModel?, Error?) -> ()) {
        dataTask?.cancel()
        if var urlComponents = URLComponents(string: "https://www.what-song.com/api/sign-in") {
            urlComponents.query = "login=\(usernameInput.text!)&password=\(passwordInput.text!)"
            guard let url = urlComponents.url else { return }
            dataTask = defaultSession.dataTask(with: url) { data, response, error in
                defer { self.dataTask = nil }
                if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    do  {
                        let loginData = try JSONDecoder().decode(LoginModel.self, from: data)
                        completion(loginData, nil)
                    } catch {
                        completion(nil, error)
                    }
                }
            }
            dataTask?.resume()
        }
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
