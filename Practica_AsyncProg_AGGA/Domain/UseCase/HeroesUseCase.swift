//
//  HeroesUseCase.swift
//  Practica_AsyncProg_AGGA
//
//  Created by Alejandro Alberto Gavira García on 20/3/24.
//

import Foundation

protocol HeroesUseCaseProtocol {
    var repo: HeroesRepositoryProtocol {get set}
    func getHeroes(filter: String) async -> [Heroes]
}

final class HeroesUseCase: HeroesUseCaseProtocol {
    var repo: HeroesRepositoryProtocol
    
    init(repo: HeroesRepositoryProtocol = HeroesRepository(network: NetworkHeroes())) {
        self.repo = repo
    }
    
    func getHeroes(filter: String) async -> [Heroes] {
        await repo.getHeroes(filter: filter)
    }
    
}

final class HeroesUseCaseFake: HeroesUseCaseProtocol {
    
    var repo: HeroesRepositoryProtocol
    
    init(repo: HeroesRepositoryProtocol = HeroesRepositoryFake(network: NetworkHeroesFake())) {
        self.repo = repo
    }
    
    func getHeroes(filter: String) async -> [Heroes] {
        await repo.getHeroes(filter: filter)
    }
    
    
}
