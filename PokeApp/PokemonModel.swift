//
//  Model.swift
//  PokeApp
//
//  Created by Caroline Chan on 13/11/22.
//

import Foundation

struct PokemonModel: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let pokemons: [Pokemon]?
    
    enum CodingKeys: String, CodingKey {
        case count
        case next
        case previous
        case pokemons = "results"
    }
}

struct Pokemon: Codable {
    let name: String?
    let url: String?
    var imageURL: String?
}
