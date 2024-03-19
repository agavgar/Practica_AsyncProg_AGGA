//
//  NetworkHeroes.swift
//  Practica_AsyncProg_AGGA
//
//  Created by Alejandro Alberto Gavira García on 18/3/24.
//

import Foundation

protocol NetworkHeroesProtocol {
    func getHeroes() async -> [Heroes]
}

final class NetworkHeroes: NetworkHeroesProtocol {
    
    func getHeroes() async -> [Heroes] {
        var heroes:[Heroes] = []
        let url = "\(ConstantApp.CONST_API_URL)\(Endpoints.heroes.rawValue)"
        
        //let token = LocalDataKC().getToken()
        //var segCredential = "Bearer \(token)"
        
        var request: URLRequest = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethods.post
        //request.addValue(segCredentials, forHTTPHeaderField: HTTPMethods.auth)
        request.addValue("name", forHTTPHeaderField: "")
        
        do {
            let (data,response) = try await URLSession.shared.data(for: request)
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode == HTTPResponseCodes.SUCCES{
                    heroes = try JSONDecoder().decode([Heroes].self, from: data)
                }
            }
        }catch{
            heroes = []
        }
        
        return heroes
        
    }
    
    
    
}
