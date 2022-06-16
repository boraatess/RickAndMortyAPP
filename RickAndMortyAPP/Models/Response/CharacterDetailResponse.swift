//
//  CharacterDetailResponse.swift
//  RickAndMortyAPP
//
//  Created by bora ateş on 16.06.2022.
//

import Foundation

// MARK: - CharacterDetailResponse
struct CharacterDetailResponse: Codable {
    let id: Int
    let name, status, species, type: String
    let gender: String
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

