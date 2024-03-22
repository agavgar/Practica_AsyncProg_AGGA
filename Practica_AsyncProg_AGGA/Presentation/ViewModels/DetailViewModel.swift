//
//  DetailViewModel.swift
//  Practica_AsyncProg_AGGA
//
//  Created by Alejandro Alberto Gavira García on 22/3/24.
//

import Foundation

final class DetailViewModel {
    var transformData: Transformation?
    var heroData: Heroes?
    
    init(transformData: Transformation? = nil, heroData: Heroes? = nil) {
        self.transformData = transformData
        self.heroData = heroData
    }
    
}
