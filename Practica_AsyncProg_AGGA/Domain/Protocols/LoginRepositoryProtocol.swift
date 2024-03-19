//
//  LoginRepositoryProtocol.swift
//  Practica_AsyncProg_AGGA
//
//  Created by Alejandro Alberto Gavira García on 12/3/24.
//

import Foundation

//MARK: - Protocolo para usar las funciones de Data
protocol LoginRepositoryProtocol {
    func loginApp(user: String, password: String) async -> String //Give the Token
}

