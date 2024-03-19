//
//  AppState.swift
//  Practica_AsyncProg_AGGA
//
//  Created by Alejandro Alberto Gavira García on 12/3/24.
//

import Foundation
import Combine

enum LoginStatus {
    case none
    case succes
    case error
    case notValidated
}

// ViewModel
final class AppState {
    
    // Estado del login
    @Published var statusLogin: LoginStatus = .none
    
    // Le añadimos el useCase
    private var loginUseCase: LoginUseCaseProtocol
    
    init(loginUseCase: LoginUseCaseProtocol = LoginUseCase()) {
        self.loginUseCase = loginUseCase
    }
    
    // Functyion Login
    func loginApp(user: String, password: String) {
        
        Task{
            if (await loginUseCase.loginApp(user: user, password: password)){
                // Login succes
                self.statusLogin = .succes
            } else {
                // error login
                self.statusLogin = .error
            }
        }
        
    }
    
    func validateControlLogin(){
        Task{
            if (await loginUseCase.validateToken()){
                //Success
                self.statusLogin = .succes
            } else {
                self.statusLogin = .notValidated
            }
        }
    }
    
    func LogOut() {
        Task {
            await loginUseCase.logout()
            self.statusLogin = .none
        }
    }
    
    
    
}
