//
//  CharactersModel.swift
//  Desafio001
//
//  Created by Elder Alcantara on 10/03/21.
//

import Foundation

struct CharacterDataWrapper: Codable{
    let code: Int
    let status: String
    let data: CharacterDataContainer
}

struct CharacterDataContainer: Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [Character]
}

struct Character: Codable {
    var id: Int
    var name: String
    var description: String
    var thumbnail: CharacterImage
    
}

struct CharacterImage: Codable {
    let path: String
    let ext: String
    var url: String {
        return path + "." + ext
    }
    
    enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }
    
}

struct ComicDataWrapper: Codable {
    let code: Int
    let status: String
    let data: ComicDataContainer
}

struct ComicDataContainer: Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [Comic]
}

struct Comic: Codable {
    let id: Int?
    let title: String?
    let description: String?
    let prices: [ComicPrice]
    let thumbnail: ComicThumbnail?
    
}

struct ComicPrice: Codable {
    let type: String?
    let price: Float?
}

struct ComicThumbnail: Codable {
    let path: String
    let ext: String
    var url: String {
        return path + "." + ext
    }
    
    enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }

}

struct ComicPricesId:Codable {
    let id: Int
    let type: String
    let price: Float
}

