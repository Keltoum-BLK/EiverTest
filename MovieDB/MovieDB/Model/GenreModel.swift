//
//  GenreModel.swift
//  MovieDB
//
//  Created by Kel_Jellysh on 02/06/2021.
//

import Foundation

//MARK: - Genre

struct Genre: Decodable {
    let genres: [GenreModel]?
    
    enum CodingKeys: String, CodingKey {
        case genres
    }
}

struct GenreModel: Decodable {
    let id: Int?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "name"
    }
}
