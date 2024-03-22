//
//  TransformViewModel.swift
//  Practica_AsyncProg_AGGA
//
//  Created by Alejandro Alberto Gavira García on 21/3/24.
//

import Foundation
import Combine

final class TransformViewModel: ObservableObject{
    @Published var transformData = [Transformation]()
    var hero: Heroes
    
    private var useCase: TransformUseCaseProtocol
    
    init(useCase: TransformUseCaseProtocol = TransformUseCase(), hero:Heroes) {
        self.useCase = useCase
        self.hero = hero
        Task{
            await getTransform(id: hero.id!)
        }
        
    }
    
    func getTransform(id: UUID) async {
        let data = await useCase.getTransforms(id: id)
        
        DispatchQueue.main.async{
            self.transformData = data
        }
    }
    
    
}
