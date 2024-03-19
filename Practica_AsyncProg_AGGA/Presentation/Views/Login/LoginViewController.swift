//
//  LoginViewController.swift
//  Practica_AsyncProg_AGGA
//
//  Created by Alejandro Alberto Gavira García on 18/3/24.
//

import UIKit
import Combine
import CombineCocoa

class LoginViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var lblUserNameError: UILabel!
    @IBOutlet weak var lblPasswordError: UILabel!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    //MARK: - Models
    private var appState: AppState?
    private var user: String = ""
    private var pass: String = ""
    private var suscriptors = Set<AnyCancellable>()
    
    //MARK: - Init
    init(appState: AppState){
        self.appState = appState
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
        bindingUI()
        
    }
    
    //MARK: - Binding UI
    func bindingUI(){
        
        if let emailTextField = self.txtUsername {
            emailTextField.textPublisher
                .receive(on: DispatchQueue.main)
                .sink { [weak self] text in
                    if let user = text {
                        self?.user = user
                        if user.count != 0 {
                            self?.controlLogin()
                        }
                    }
                }
                .store(in: &suscriptors)
        }
        
        if let passTextField = self.txtPassword {
            passTextField.textPublisher
                .receive(on: DispatchQueue.main)
                .sink { [weak self] text in
                    if let pass = text {
                        self?.pass = pass
                        if pass.count != 0{
                            self?.controlLogin()
                        }
                    }
                }
                .store(in: &suscriptors)
        }
        
        // Login Button
        if let loginButton = self.btnLogin {
            loginButton.tapPublisher
                .sink { [weak self] _ in
                    if let user = self?.user, let pass = self?.pass {
                        self?.appState?.loginApp(user: user, password: pass)
                    }
                }
                .store(in: &suscriptors)
            
            
        }
    }
    
    //MARK: - Preparation UI
    func updateUI() {
        DispatchQueue.main.async {
            self.btnLogin.isHidden = true
            self.lblPasswordError.isHidden = true
            self.lblUserNameError.isHidden = true
            self.btnLogin.tintColor = .yellow
        }
    }
    
    //MARK: - Login Button Control
    func controlLogin(){
        if user.count > 0 && user.count < 4 {
            DispatchQueue.main.async {
                self.btnLogin.isHidden = true
                self.lblUserNameError.isHidden = false
            }
        }else if pass.count > 0 && pass.count < 4 {
            DispatchQueue.main.async {
                self.btnLogin.isHidden = true
                self.lblPasswordError.isHidden = false
            }
        }else if user.count >= 4 && pass.count >= 4 {
            DispatchQueue.main.async {
                self.lblUserNameError.isHidden = true
                self.lblPasswordError.isHidden = true
                self.btnLogin.isHidden = false
            }
        }else if user.count >= 4{
            DispatchQueue.main.async {
                self.lblUserNameError.isHidden = true
            }
        }else if pass.count >= 4{
            DispatchQueue.main.async {
                self.lblPasswordError.isHidden = true
            }
        }
    }
    
    
    
}
