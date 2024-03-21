//
//  NetworkTransforms.swift
//  Practica_AsyncProg_AGGA
//
//  Created by Alejandro Alberto Gavira García on 21/3/24.
//

import Foundation
import KeychainSwift

protocol NetworkTransformsProtocol {
    func getTransforms(id: UUID) async -> [Transformation]
}

final class NetworkTransforms: NetworkTransformsProtocol {
    func getTransforms(id: UUID) async -> [Transformation] {
        var transformation = [Transformation]()
        let url = URL(string: "\(ConstantApp.CONST_API_URL)\(Endpoints.transform.rawValue)")
        
        var segCredentials = ""
        if let token = KeychainSwift().get(ConstantApp.CONST_TOKEN_ID_KC){
            segCredentials = "Bearer \(token)"
        }
        
        var request = URLRequest(url: url!)
        request.httpMethod = HTTPMethods.post
        request.httpBody = try? JSONEncoder().encode(TransformationRequest(id: id))
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type")
        request.addValue(segCredentials, forHTTPHeaderField: HTTPMethods.auth)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode == HTTPResponseCodes.SUCCES{
                    transformation = try JSONDecoder().decode([Transformation].self, from: data)
                }
            }
            
        }catch {
            transformation = []
        }
        
        return transformation
    }
    
    
}

final class NetworkTransformsFake: NetworkTransformsProtocol {
    func getTransforms(id: UUID) async -> [Transformation] {
        
        let model1 = Transformation(id: UUID(), name: "1. Oozaru – Gran Mono", description: "Cómo todos los Saiyans con cola, Goku es capaz de convertirse en un mono gigante si mira fijamente a la luna llena. Así es como Goku cuando era un infante liberaba todo su potencial a cambio de perder todo el raciocinio y transformarse en una auténtica bestia. Es por ello que sus amigos optan por cortarle la cola para que no ocurran desgracias, ya que Goku mató a su propio abuelo adoptivo Son Gohan estando en este estado. Después de beber el Agua Ultra Divina, Goku liberó todo su potencial sin necesidad de volver a convertirse en Oozaru", photo: "https://areajugones.sport.es/wp-content/uploads/2021/05/ozarru.jpg.webp",hero: Heroes(id: UUID(uuidString: "D13A40E5-4418-4223-9CE6-D2F9A28EBE94"), name: nil, description: nil, favorite: nil, photo: nil))
                      
        let model2 = Transformation(id: UUID(), name: "1. Oozaru – Gran Mono", description: "Cómo todos los Saiyans con cola, Goku es capaz de convertirse en un mono gigante si mira fijamente a la luna llena. Así es como Goku cuando era un infante liberaba todo su potencial a cambio de perder todo el raciocinio y transformarse en una auténtica bestia. Es por ello que sus amigos optan por cortarle la cola para que no ocurran desgracias, ya que Goku mató a su propio abuelo adoptivo Son Gohan estando en este estado. Después de beber el Agua Ultra Divina, Goku liberó todo su potencial sin necesidad de volver a convertirse en Oozaru", photo: "https://areajugones.sport.es/wp-content/uploads/2021/05/ozarru.jpg.webp",hero: Heroes(id: UUID(uuidString: "D13A40E5-4418-4223-9CE6-D2F9A28EBE94"), name: nil, description: nil, favorite: nil, photo: nil))
        
        let model3 = Transformation(id: UUID(), name: "14. Ultra instinto", description: "Realmente no se debería llamar transformación al Ultra Instinto, puesto que es más una técnica que una transformación en sí, pero puesto a que el pelo de Goku se tinta de color blanco o plateado, sí que puede considerarse una nueva transformación, puesto que su apariencia física y su pelo vuelven a cambiar de forma radical al que conocemos como su estado base. Esta transformación la pudimos ver por primera vez en los instantes finales del episodio 129 de Dragon Ball Super, cuando Goku sorprendió a Jiren y a todos los Dioses al ser capaz de dominar este movimiento que sólo los Ángeles parecen capaces de controlar al completo.", photo: "https://areajugones.sport.es/wp-content/uploads/2020/03/goku-ultra-instinto-draogn-ball-fighterz-min.jpg",hero: Heroes(id: UUID(uuidString: "6E1B907C-EB3A-45BA-AE03-44FA251F64E9"), name: nil, description: nil, favorite: nil, photo: nil))
        
        let model4 = Transformation(id: UUID(), name: "2. Super Saiyajin", description: "La primera vez que vemos a Vegeta transformado en Super Saiyajin es en la batalla contra los androides Dr. Gero y Número 19. Durante esta batalla el propio príncipe saiyajin cuenta como accedió a este nuevo nivel de poder tras sentir envidia de Goku y Trunks del futuro.", photo: "https://areajugones.sport.es/wp-content/uploads/2019/07/VegetaSS-1024x576.jpg.webp",hero: Heroes(id: UUID(uuidString: "6E1B907C-EB3A-45BA-AE03-44FA251F64E9"), name: nil, description: nil, favorite: nil, photo: nil))
        
        if id == UUID(uuidString: "D13A40E5-4418-4223-9CE6-D2F9A28EBE94") {
            return [model1,model2]
        }else {
            return [model3, model4]
        }
        
        

        
    }
    
    
    
}
