//
//  CharacterAPIRequest.swift
//  RickAndMortyTestMVVM
//
//  Created by _deniro0001_ on 08.04.2021.
//

import Foundation

protocol CharacterRequestProtocol: AnyObject {
    func getCharacters (completion: @escaping(Result<[Character], CharacterAPIError>) -> Void)
}

class CharacterRequest: CharacterRequestProtocol {
    
    let resourceURL: URL
    
    init() {
        
        let resourceStr = "https://rickandmortyapi.com/api/character/"
        guard let resourceURL = URL(string: resourceStr) else {fatalError()}
        
        self.resourceURL = resourceURL
    }
    
    func getCharacters (completion: @escaping(Result<[Character], CharacterAPIError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let charctersResponse = try decoder.decode(CharacterResponse.self, from: jsonData)
                let results = charctersResponse.results
                completion(.success(results))
            }catch{
                completion(.failure(.canNotProcessData))
            }
        }
        
        dataTask.resume()
    }
}
