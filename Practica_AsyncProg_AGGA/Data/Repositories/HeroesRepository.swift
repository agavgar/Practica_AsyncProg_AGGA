//
//  HeroesRepository.swift
//  Practica_AsyncProg_AGGA
//
//  Created by Alejandro Alberto Gavira García on 20/3/24.
//

import Foundation

final class HeroesRepository: HeroesRepositoryProtocol {
    private var network: NetworkHeroesProtocol
    
    init(network: NetworkHeroesProtocol = NetworkHeroes()) {
        self.network = network
    }
    
    func getHeroes(filter: String) async -> [Heroes] {
        return await network.getHeroes(filter: filter)
    }
    
}

final class HeroesRepositoryFake: HeroesRepositoryProtocol{
    private var network: NetworkHeroesProtocol
    
    init(network: NetworkHeroesProtocol = NetworkHeroesFake()) {
        self.network = network
    }
    
    func getHeroes(filter: String) async -> [Heroes] {
        return await network.getHeroes(filter: filter)
    }
}
