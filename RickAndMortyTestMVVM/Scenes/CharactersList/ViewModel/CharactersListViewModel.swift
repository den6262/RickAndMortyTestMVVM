//
//  CharactersListViewModel.swift
//  RickAndMortyTestMVVM
//
//  Created by _deniro0001_ on 09.04.2021.
//

import Foundation

class CharactersListViewModel {
    
    //MARK: - Closures
    var reloadTableViewClosure: (()->())?
    var updateLoadingStatusClosure: (()->())?
    
    //MARK: - Vars
    let apiService: CharacterRequestProtocol
    
    var isLoaded: Bool = false
    
    var selectedCharacter: Character?
    
    private var characters: [Character] = [Character]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    var sortedFirstLetters: [String] = [] {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    var sections: [[Character]] = [[]]
    
    var numberOfItems: Int {
        return characters.count
    }
    
    //MARK: - Constructor
    init(apiService: CharacterRequestProtocol = CharacterRequest()) {
        self.apiService = apiService
    }
    
    //MARK: - Fetching functions
    func fetchData() {
        
        apiService.getCharacters { [weak self] (result) in
            
            guard let self = self else { return }
            
            switch result {
            
            case .success(let characters):
                self.characters = characters
                
                let firstLetters = characters.map { $0.titleFirstLetter }
                let uniqueFirstLetters = Array(Set(firstLetters))
                
                self.sortedFirstLetters = uniqueFirstLetters.sorted()
                
                print(self.sortedFirstLetters.count)
                
                self.sections = self.sortedFirstLetters.map { firstLetter in
                    return characters
                        .filter { $0.titleFirstLetter == firstLetter }
                        .sorted { $0.name < $1.name }
                }
                
            case .failure(let error):
                print ("Error: \(error.rawValue)")
            }
            
            self.isLoaded = true
        }
    }
    
    
    //MARK: - Retieve Data
    func getData( at indexPath: IndexPath ) -> Character {
        return sections[indexPath.section][indexPath.row]
    }
}
