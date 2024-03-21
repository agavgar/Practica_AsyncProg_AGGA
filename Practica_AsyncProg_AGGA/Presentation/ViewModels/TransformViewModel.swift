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
    private var idHeroe: UUID
    
    private var useCase: TransformUseCaseProtocol
    
    init(useCase: TransformUseCaseProtocol = TransformUseCase(), id:UUID) {
        self.useCase = useCase
        self.idHeroe = id
        Task{
            await getTransform(id: idHeroe)
        }
        
    }
    
    func getTransform(id: UUID) async {
        let data = await useCase.getTransforms(id: id)
        
        DispatchQueue.main.async{
            self.transformData = data
        }
    }
    
    
}
