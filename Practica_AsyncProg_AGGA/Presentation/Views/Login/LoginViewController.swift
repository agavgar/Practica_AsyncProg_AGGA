//
//  LoginViewController.swift
//  Practica_AsyncProg_AGGA
//
//  Created by Alejandro Alberto Gavira García on 18/3/24.
//

import UIKit
import Combine

class LoginViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var lblUserNameError: UILabel!
    @IBOutlet weak var lblPasswordError: UILabel!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    //MARK: - Models
    private var appState: AppState?
    
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

    }

}
