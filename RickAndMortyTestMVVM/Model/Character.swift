//
//  Character.swift
//  RickAndMortyTestMVVM
//
//  Created by _deniro0001_ on 08.04.2021.
//

import Foundation

struct CharacterResponse: Decodable {
    let results: [Character]
}

struct CharacterLocation: Decodable {
    let name: String
    let url: String
}

struct Character: Decodable {
    var name: String
    let id: Int
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Location
    let location: Location
    let image: URL
    let episode: [String]
    let url: String
    let created: String
    
    var titleFirstLetter: String {
        return String(self.name[self.name.startIndex]).uppercased()
    }
}

struct Location: Decodable {
    let name: String
    let id: Int?
    let type: String?
    let dimension: String?
    let residents: [String]?
    let url: String
    let created: String?
}
