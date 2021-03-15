//
//  ComicWorker.swift
//  Desafio001
//
//  Created by Elder Alcantara on 12/03/21.
//

import Foundation
import SwiftHash



class ComicWorker {
    
    var listComicPricesId: [ComicPricesId] = []
    
    
    typealias completion <T> = (_ result: T, _ success: Bool?) -> Void
    
    func loadComics(characterId: Int, completion: @escaping completion<[Comic]?>) {
        
        let session: URLSession = URLSession.shared
        let url: URL? = URL(string: ComicWorker.getURL(characterId: characterId))
        
        if let _url = url {
            
            let task: URLSessionTask = session.dataTask(with: _url) { (data, response, error) in
                print(">>>RESPONSE > COMIC: \(String(describing: response))")
                
                do {
                    let json = try JSONDecoder().decode(ComicDataWrapper.self, from: data ?? Data())
                    print(">>>JSON > COMIC: \(json)")
                    completion(json.data.results, true)
                    
                } catch {
                    print(">>>JSON ERROR > COMIC \(error)")
                    completion(nil, false)
                    
                }
                
            }
            
            task.resume()
        }
        
        
    }
    
    
    
    
    private class func getCredentials() -> String{
        
        let privateKey = "6f6a9efa50e2450dadf0de625942716fb3f0ae41"
        let publicKey = "fed95c7592c6af3fe3a4e9bc105129a1"
        
        let ts = String(Date().timeIntervalSince1970)
        let hash  = MD5(ts+privateKey+publicKey).lowercased()
        
        return "ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
        
    }
    
    
    private class func getURL(characterId: Int) -> String {
        
        let basePath: String = "https://gateway.marvel.com:443/v1/public/characters/\(characterId)/comics?"
        
        let url = basePath + self.getCredentials()
        
        return url
        
    }
    
    
    
    func listMostExpensiveComics(comics: [Comic], completion: @escaping completion<[ComicPricesId]?>) {
        
        //create list of comics with id, type and value
        for Revista in comics {
            
            var _id: Int = 0
            
            for Price in Revista.prices {
                
                var _type: String = ""
                var _price: Float = 0
                
                _id = Revista.id ?? 0
                _type = Price.type ?? ""
                _price = Price.price ?? 0
                
                listComicPricesId.append(ComicPricesId.init(id: _id, type: _type, price: _price))
                
            }
            
        }
        
        // create list with prices only
        var listPrices: [Float] = []
        for Price in listComicPricesId {
            listPrices.append(Price.price)
        }
        
        // set highest value in the list of with prices only
        let mostExpensivePrice: Float = listPrices.max() ?? 0
        print(listPrices.max() ?? 0)
        
        
        //create ID list of the most expensive comics
        let mostExpensiveComics:Float = mostExpensivePrice
        var listMostExpensiveComics: [ComicPricesId] = []
        
        listComicPricesId.forEach {
            
            print(">>> ID: \($0.id) / TYPE: \($0.type) / PRICE: \($0.price)")
            
            if mostExpensiveComics == $0.price {
                listMostExpensiveComics.append(ComicPricesId.init(id: $0.id, type: $0.type, price: $0.price))
            }
            
        }
        
        
        print(listMostExpensiveComics)
        
        if listMostExpensiveComics.count > 0 {
            completion(listMostExpensiveComics, true)
        } else {
            completion(nil, false)
        }
        
        
    }
    
    
    
    
}
