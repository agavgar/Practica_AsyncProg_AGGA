//
//  TransformUseCase.swift
//  Practica_AsyncProg_AGGA
//
//  Created by Alejandro Alberto Gavira García on 21/3/24.
//

import Foundation

protocol TransformUseCaseProtocol {
    var repo: TransformationRepositoryProtocol { get set }
    func getTransforms(id: UUID) async -> [Transformation]
}

final class TransformUseCase: TransformUseCaseProtocol {
    var repo: TransformationRepositoryProtocol
    
    init(repo: TransformationRepositoryProtocol = TransformationRepository()) {
        self.repo = repo
    }
    
    func getTransforms(id: UUID) async -> [Transformation] {
        return await repo.getTransforms(id: id)
    }
}

final class TransformUseCaseFake: TransformUseCaseProtocol{
    var repo: TransformationRepositoryProtocol
    
    init(repo: TransformationRepositoryProtocol = TransformationRepositoryFake()) {
        self.repo = repo
    }
    
    func getTransforms(id: UUID) async -> [Transformation] {
        return await repo.getTransforms(id: id)
    }
}
