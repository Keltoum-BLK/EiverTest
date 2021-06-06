//
//  Movie.swift
//  MovieDB
//
//  Created by Kel_Jellysh on 01/06/2021.
//

import Foundation


struct List: Decodable {
    let listOf: [ListMovie]

    private enum CodingKeys: String, CodingKey {
        case listOf = "results"
    }

}

struct ListMovie: Decodable {
    
    let id: Int?
    let title: String?
   

   
    enum CodingKeys: String, CodingKey {
        case id
        case title
    }
}

