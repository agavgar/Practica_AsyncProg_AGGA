//
//  NetworkHeroes.swift
//  Practica_AsyncProg_AGGA
//
//  Created by Alejandro Alberto Gavira García on 18/3/24.
//

import Foundation
import KeychainSwift

protocol NetworkHeroesProtocol {
    func getHeroes(filter:String) async -> [Heroes]
}

final class NetworkHeroes: NetworkHeroesProtocol {
    
    func getHeroes(filter:String) async -> [Heroes] {
        var heroes = [Heroes]()
        let url = "\(ConstantApp.CONST_API_URL)\(Endpoints.heroes.rawValue)"
        
        var segCredential = ""
        if let token = KeychainSwift().get(ConstantApp.CONST_TOKEN_ID_KC){
            segCredential = "Bearer \(token)"
        }
        
        var request: URLRequest = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethods.post
        request.httpBody = try? JSONEncoder().encode(HerosRequest(name: filter))
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type")
        request.addValue(segCredential, forHTTPHeaderField: HTTPMethods.auth)
        
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

final class NetworkHeroesFake: NetworkHeroesProtocol {
    func getHeroes(filter: String) async -> [Heroes] {
        
        let model1 = Heroes(id: UUID(), name: "Goku",  description: "Sobran las presentaciones cuando se habla de Goku. El Saiyan fue enviado al planeta Tierra, pero hay dos versiones sobre el origen del personaje. Según una publicación especial, cuando Goku nació midieron su poder y apenas llegaba a dos unidades, siendo el Saiyan más débil. Aun así se pensaba que le bastaría para conquistar el planeta. Sin embargo, la versión más popular es que Freezer era una amenaza para su planeta natal y antes de que fuera destruido, se envió a Goku en una incubadora para salvarle.",favorite: true, photo: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/goku1.jpg?width=300")
        let model2 = Heroes(id: UUID(), name: "Vegeta",  description: "Vegeta es todo lo contrario. Es arrogante, cruel y despreciable. Quiere conseguir las bolas de Dragón y se enfrenta a todos los protagonistas, matando a Yamcha, Ten Shin Han, Piccolo y Chaos. Es despreciable porque no duda en matar a Nappa, quien entonces era su compañero, como castigo por su fracaso. Tras el intenso entrenamiento de Goku, el guerrero se enfrenta a Vegeta y estuvo a punto de morir. Lejos de sobreponerse, Vegeta huye del planeta Tierra sin saber que pronto tendrá que unirse a los que considera sus enemigos.",favorite: true, photo: "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/vegetita.jpg?width=300")
        
       return [model1, model2]
    }
}
