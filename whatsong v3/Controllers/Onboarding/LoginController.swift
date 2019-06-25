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
    var popupAlert: UIView!

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
        label.text = "Log in"
        label.font = UIFont(name: "FatFrank", size: 28)
        label.textColor = UIColor.brandBlack()
        return label
    }()
    
    let usernameInput: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = UIColor.backgroundGrey()
        tf.autocapitalizationType = .none
        tf.textColor = UIColor.brandBlack()
        tf.font = UIFont(name: "Montserrat-Regular", size: 16)
        let attributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.brandBlack(),
            NSAttributedString.Key.font : UIFont(name: "Montserrat-Regular", size: 16)!,
            NSAttributedString.Key.kern: -0.2
            ]
        tf.attributedPlaceholder = NSAttributedString(string: "Username", attributes: attributes)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        tf.setBottomBorder(color: .brandBlack())
        return tf
    }()
    
    let passwordInput: UITextField = {
        let tf = UITextField()
        tf.isSecureTextEntry = true
        tf.backgroundColor = UIColor.backgroundGrey()
        tf.textColor = UIColor.brandBlack()
        tf.font = UIFont(name: "Montserrat-Regular", size: 16)
        let attributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.brandBlack(),
            NSAttributedString.Key.font : UIFont(name: "Montserrat-Regular", size: 16)!,
            NSAttributedString.Key.kern: -0.2
        ]
        tf.attributedPlaceholder = NSAttributedString(string: "Password", attributes: attributes)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        tf.setBottomBorder(color: .brandBlack())
        return tf
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 223/255, green: 219/255, blue: 245/255, alpha: 1)
        button.isEnabled = false
        button.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 16)
        button.setTitle("Log in", for: .normal)
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        return button
    }()
    
    let dismissButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "back-icon"), for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(UIColor.brandDarkGrey(), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setupViews()   {
        
        view.backgroundColor = UIColor.backgroundGrey()
        
        let stackView = UIStackView(arrangedSubviews: [usernameInput, passwordInput, loginButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.constrainHeight(constant: 180)
        stackView.spacing = 14
        
        view.addSubview(dismissButton)
        view.addSubview(loginHeading)
        view.addSubview(stackView)
        
        dismissButton.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 80, left: 20, bottom: 0, right: 0))
        loginHeading.anchor(top: dismissButton.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 20, left: 20, bottom: 0, right: 0))
        stackView.anchor(top: loginHeading.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 40, left: 20, bottom: 0, right: 20))
        
        
    }
    
    @objc func handleTextInputChange()    {
        let isFormValid = usernameInput.text?.count ?? 0 > 2 && passwordInput.text?.count ?? 0 > 2
        
        if isFormValid {
            loginButton.isEnabled = true
            loginButton.backgroundColor = UIColor.brandPurple()
        } else  {
            loginButton.isEnabled = false
            loginButton.backgroundColor = UIColor(red: 223/255, green: 219/255, blue: 245/255, alpha: 1)
            
        }
    }
    
    @objc func loginAction() {
        handleLogin { (loginModel, error, errorMessage) in
            if error != nil {
                
                self.displayAlert(userMessage: error!.localizedDescription)
                // show error alert
                return
            }
            if errorMessage != nil {
                self.displayAlert(userMessage: errorMessage!)
                
                return
            }
            if let model = loginModel {
                DAKeychain.shared["accessToken"] = model.data.accessToken.value
                DispatchQueue.main.async {
                    //reset app state after successful login
                    guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else { return }
                    mainTabBarController.setupLoggedInViewControllers()

                        self.view.window?.rootViewController?.dismiss(animated: true, completion: {
                        // completion handler after successful login
                            self.showAlert(bgColor: UIColor.brandSuccess(), text: "You have successfully logged in")
                    })
                }
            } else {
            }
        }
    }
    
    func handleLogin(completion: @escaping (LoginModel?, Error?, String?) -> ()) {
        dataTask?.cancel()
        startActivityIndicator()
        if var urlComponents = URLComponents(string: "https://www.what-song.com/api/sign-in") {
            urlComponents.query = "login=\(usernameInput.text!)&password=\(passwordInput.text!)"
            guard let url = urlComponents.url else { return }
            dataTask = defaultSession.dataTask(with: url) { data, response, error in
                defer { self.dataTask = nil }
                if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    do  {
                        self.stopActivityIndicator()
                        let loginData = try JSONDecoder().decode(LoginModel.self, from: data)
                        completion(loginData, nil, nil)
                    } catch {
                        self.stopActivityIndicator()
                        completion(nil, error, nil)
                    }
                } else {
                    self.stopActivityIndicator()
                    completion(nil, error, "Wrong login or password")
                }
            }
            dataTask?.resume()
        }
    }
    
    @objc func handleDismiss()    {
        self.dismiss(animated: true, completion: nil)
    }
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView()
        aiv.color = UIColor.brandLightGrey()
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
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
                    alertController.dismiss(animated: true, completion: nil)
                }
            })
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
