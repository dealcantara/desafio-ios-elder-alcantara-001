//
//  CharactersViewModel.swift
//  Desafio001
//
//  Created by Elder Alcantara on 10/03/21.
//

import Foundation


class CharactersViewModel {
    
    let worker: CharactersWorker = CharactersWorker()
    
    private var arrayCharacters: [Character] = []
    var currentCharacter: Character?
    
    
    func getListHeroes(completion: @escaping (Bool) -> Void) {
        
        self.worker.loadHeroes { (response, success) in
            
            if success == true {
                
                self.arrayCharacters = response ?? []
                completion(true)
                print(self.arrayCharacters)
                
            } else {
                
                print(">>> Error in CharactersViewModel > getListHeroes")
                completion(false)
                
            }
            
        }
        
        
    }
    
    
    var numberOfCharacters: Int {
        return self.arrayCharacters.count
    }
    
    func setCurrentCharacter(index: Int) {
        self.currentCharacter = self.arrayCharacters[index]
    }
    
    var charactersName: String {
        return self.currentCharacter?.name ?? ""
    }
    
    var charactersDescription: String {
        return self.currentCharacter?.description ?? ""
    }
    
    var charactersImage: String {
        return self.currentCharacter?.thumbnail.url ?? ""
    }
    
    var charactersList: [Character] {
        return self.arrayCharacters
    }
    
    
    
    
}
