//
//  Models.swift
//  Practica_AsyncProg_AGGA
//
//  Created by Alejandro Alberto Gavira García on 18/3/24.
//

import Foundation

struct Heroes: Decodable {
    let id: UUID?
    let name: String?
    let description: String?
    let favorite: Bool?
    let photo: String?
}
