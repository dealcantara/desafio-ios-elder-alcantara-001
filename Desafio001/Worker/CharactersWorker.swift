//
//  CharactersWorker.swift
//  Desafio001
//
//  Created by Elder Alcantara on 10/03/21.
//

import Foundation
import SwiftHash



class CharactersWorker {
    typealias completion <T> = (_ result: T, _ success: Bool?) -> Void
    
    func loadHeroes(completion: @escaping completion<[Character]?>) {
        
        let session: URLSession = URLSession.shared
        let url: URL? = URL(string: CharactersWorker.getURL())
        
        if let _url = url {
            
            let task: URLSessionTask = session.dataTask(with: _url) { (data, response, error) in
                print(">>>RESPONSE: \(String(describing: response))")
                
                do {
                    //let json = try JSONSerialization.jsonObject(with: data ?? Data(), options: [])
                    let json = try JSONDecoder().decode(CharacterDataWrapper.self, from: data ?? Data())
                    print(">>>JSON: \(json)")
                    completion(json.data.results, true)
                    
                } catch {
                    
                    print(">>>ERROR in CharactersWorker > loadHeroes \(error)")
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
    
    
    private class func getURL() -> String {
        
        let basePath: String = "https://gateway.marvel.com/v1/public/characters?"
        //let limit: Int = 100
        //let offset: Int = 0 * limit
        
        
        //let url = basePath + "nameStartsWith=iron&offset=\(offset)&limit=\(limit)&" + self.getCredentials()
        let url = basePath + self.getCredentials()
        
        return url
        
    }
    
    
    
    
}
