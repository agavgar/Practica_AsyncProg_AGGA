//
//  HeroesRepositoryProtocol.swift
//  Practica_AsyncProg_AGGA
//
//  Created by Alejandro Alberto Gavira García on 20/3/24.
//

import Foundation

protocol HeroesRepositoryProtocol{
    func getHeroes(filter:String) async -> [Heroes]
}
