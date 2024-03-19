//
//  LoginRepository.swift
//  Practica_AsyncProg_AGGA
//
//  Created by Alejandro Alberto Gavira García on 12/3/24.
//

import Foundation

// Real
final class LoginRepository: LoginRepositoryProtocol {
    private var Network: NetworkLoginProtocol
    
    init(Network: NetworkLoginProtocol) {
        self.Network = Network
    }
    
    func loginApp(user: String, password: String) async -> String {
        return await Network.loginApp(user: user, password: password)
    }
    
}

// fake
final class LoginRepositoryFake: LoginRepositoryProtocol {
    private var Network: NetworkLoginProtocol
    
    init(Network: NetworkLoginProtocol = NetworkLoginFake()) {
        self.Network = Network
    }
    
    func loginApp(user: String, password: String) async -> String {
        return await Network.loginApp(user: user, password: password)
    }
    
}
