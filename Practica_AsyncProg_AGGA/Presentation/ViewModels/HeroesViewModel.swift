//
//  HerosViewModel.swift
//  Practica_AsyncProg_AGGA
//
//  Created by Alejandro Alberto Gavira García on 20/3/24.
//

import Foundation
import Combine

final class HeroesViewModel: ObservableObject {
    @Published var heroData = [Heroes]()
    
    private var useCase: HeroesUseCaseProtocol
    
    init(useCase: HeroesUseCaseProtocol = HeroesUseCase()) {
        self.useCase = useCase
        
        Task{
         await getHeroes()
        }
    }
    
    func getHeroes() async {
        let data = await useCase.getHeroes(filter: "")
        
        DispatchQueue.main.async {
            self.heroData = data
        }
    }
    
}
