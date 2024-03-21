//
//  TransformationRepository.swift
//  Practica_AsyncProg_AGGA
//
//  Created by Alejandro Alberto Gavira García on 21/3/24.
//

import Foundation

final class TransformationRepository: TransformationRepositoryProtocol {
    private var network: NetworkTransformsProtocol
    
    init(network: NetworkTransformsProtocol = NetworkTransforms()) {
        self.network = network
    }
    
    func getTransforms(id: UUID) async -> [Transformation] {
       return await network.getTransforms(id: id)
    }
    
    
}

final class TransformationRepositoryFake: TransformationRepositoryProtocol {
    var network: NetworkTransformsProtocol
    
    init(network: NetworkTransformsProtocol = NetworkTransformsFake()) {
        self.network = network
    }
    
    func getTransforms(id: UUID) async -> [Transformation] {
        return await network.getTransforms(id: id)
    }
}
