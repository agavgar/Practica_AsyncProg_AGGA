//
//  TransformationRepositoryProtocol.swift
//  Practica_AsyncProg_AGGA
//
//  Created by Alejandro Alberto Gavira García on 21/3/24.
//

import Foundation

protocol TransformationRepositoryProtocol {
    func getTransforms(id:UUID) async -> [Transformation]
}
