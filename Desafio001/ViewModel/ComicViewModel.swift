//
//  ComicViewModel.swift
//  Desafio001
//
//  Created by Elder Alcantara on 12/03/21.
//

import Foundation


class ComicViewModel {
    
    let worker: ComicWorker = ComicWorker()
    
    var arrayComics: [Comic] = []
    var arrayMostExpensiveComic: [ComicPricesId] = []
    
    var comicImage: String = ""
    var comicTitle: String = ""
    var comicDescription: String = ""
    var comicPrice: String = ""
    
    
    
    func getListComics(characterId: Int, completion: @escaping (Bool) -> Void) {
        
        self.worker.loadComics(characterId: characterId) { (response, success) in
            
            if success == true {
                
                self.arrayComics = response ?? []
                //completion(true)
                print(self.arrayComics)
                
                if self.arrayComics.count == 0 {
                    completion(false)
                    print(">>> arrayComics empty")
                } else {
                    completion(true)
                }
                
            } else {
                
                print(">>> Error in CharactersViewModel > getListHeroes")
                completion(false)
                
            }
            
        }
        
    }
    
    
    
    
    func getMostExpensiveComic(completion: @escaping (Bool) -> Void) {
        
        self.worker.listMostExpensiveComics(comics: self.arrayComics) { (response, success) in
            
            if success == true {
                
                self.arrayMostExpensiveComic = response ?? []
                completion(true)
                
            } else {
                
                print(">>> Error in CharactersViewModel > getMostExpensiveComic")
                completion(false)
                
            }
            
        }
        
    }
    
    func getDetailsMostExpensiveComic(){
        
        arrayComics.forEach {
            
            if $0.id == arrayMostExpensiveComic[0].id {
                comicImage = String($0.thumbnail?.url ?? "")
                comicTitle = String($0.title ?? "")
                comicDescription = String($0.description ?? "")
                comicPrice = String("$ \(arrayMostExpensiveComic[0].price)")
                
            }
            
            
        }
    }
    
}
