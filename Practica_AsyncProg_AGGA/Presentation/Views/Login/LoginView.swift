//
//  LoginView.swift
//  Practica_AsyncProg_AGGA
//
//  Created by Alejandro Alberto Gavira García on 12/3/24.
//

import Foundation
import UIKit

//MARK: - Generate UI code
class LoginView: UIView {
    
    //MARK: - Properties
    
    ///Logo
    ///
    public let logoImage = {
        let image = UIImageView(image: UIImage(named: "title"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    ///User
    ///
    public let emailTextField = {
        let textField = UITextField()
        textField.backgroundColor = .blue.withAlphaComponent(0.9)
        textField.textColor = .white
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Email"
        textField.layer.cornerRadius = 10
        textField.layer.masksToBounds = true // We don't see the corner radius
        return textField
    }()
    
    ///Password
    ///
    public let passwordTextField = {
        let textField = UITextField()
        textField.backgroundColor = .blue.withAlphaComponent(0.9)
        textField.textColor = .white
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        textField.layer.cornerRadius = 10
        textField.layer.masksToBounds = true // We don't see the corner radius
        textField.isSecureTextEntry = true // Check so we can't see the password writed
        return textField
    }()
    
    ///boton
    ///
    public let buttonLogin = {
        let button = UIButton()
        button.setTitle("Login", for: .normal) // Change to DISABLED
        button.backgroundColor = .blue.withAlphaComponent(0.9)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.gray, for: .disabled)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    required init?(coder: NSCoder) {
        fatalError("Can't Load LoginView in Controller")
    }
    
    //MARK: - Methods
    func setUpViews(){
        // Add the UIItems to View
        let backImage = UIImage(named: "fondo3")!
        backgroundColor = UIColor(patternImage: backImage)
        
        addSubview(logoImage)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(buttonLogin)
        
        /// Auto Layout
        ///
        NSLayoutConstraint.activate([
                    //logo
                    logoImage.topAnchor.constraint(equalTo: topAnchor, constant: 120),
                    logoImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                    logoImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                    logoImage.heightAnchor.constraint(equalToConstant: 70),
                    //user
                    emailTextField.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 100),
                    emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
                    emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
                    emailTextField.heightAnchor.constraint(equalToConstant: 50),
                    //pass
                    passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 40),
                    passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
                    passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
                    passwordTextField.heightAnchor.constraint(equalToConstant: 50),
                    //boton
                    buttonLogin.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 75),
                    buttonLogin.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 80),
                    buttonLogin.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -80),
                    buttonLogin.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func getEmailView() -> UITextField {
        return emailTextField
    }
    
    func getPasswordView() -> UITextField {
        return passwordTextField
    }
    
    func getLogoImageView() -> UIImageView {
        return logoImage
    }
    
    func getButtonLoginView() -> UIButton {
        return buttonLogin
    }
}
