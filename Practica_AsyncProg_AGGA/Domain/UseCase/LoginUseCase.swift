//
//  LoginUseCase.swift
//  Practica_AsyncProg_AGGA
//
//  Created by Alejandro Alberto Gavira García on 12/3/24.
//

import Foundation
import KeychainSwift

protocol LoginUseCaseProtocol {
    var repo: LoginRepositoryProtocol {get set}
    func loginApp(user: String, password: String) async -> Bool
    func logout() async -> Void
    func validateToken() async -> Bool
}

final class LoginUseCase: LoginUseCaseProtocol {
    var repo: LoginRepositoryProtocol
    
    init(repo: LoginRepositoryProtocol = LoginRepository(Network: NetworkLogin())) {
        self.repo = repo
    }
    
    func loginApp(user: String, password: String) async -> Bool {
        let token = await repo.loginApp(user: user, password: password)
        
        if token != "" {
            KeychainSwift().set(token, forKey: ConstantApp.CONST_TOKEN_ID_KC)
            return true
        } else {
            KeychainSwift().delete(ConstantApp.CONST_TOKEN_ID_KC)
            return false
        }
    }
    
    func logout() async {
        //Logout
        KeychainSwift().delete(ConstantApp.CONST_TOKEN_ID_KC)
    }
    
    func validateToken() async -> Bool {
        if KeychainSwift().get(ConstantApp.CONST_TOKEN_ID_KC) != "" && KeychainSwift().get(ConstantApp.CONST_TOKEN_ID_KC) != nil {
            return true
        } else {
            return false
        }
    }
    
    
}

final class LoginUseCaseFake: LoginUseCaseProtocol {
    var repo: LoginRepositoryProtocol
    
    init(repo: LoginRepositoryProtocol = LoginRepositoryFake()) {
        self.repo = repo
    }
    
    func loginApp(user: String, password: String) async -> Bool {
        let token = await repo.loginApp(user: user, password: password)
        
        if token != "" {
            KeychainSwift().set(token, forKey: ConstantApp.CONST_TOKEN_ID_KC)
            return true
        } else {
            KeychainSwift().delete(ConstantApp.CONST_TOKEN_ID_KC)
            
            return false
        }
    }
    
    func logout() async {
        //Logout
        KeychainSwift().delete(ConstantApp.CONST_TOKEN_ID_KC)

    }
    
    func validateToken() async -> Bool {
        if KeychainSwift().get(ConstantApp.CONST_TOKEN_ID_KC) != "" {
            return true
        } else {
            return false
        }
    }
    
    
}
