//
//  Movie.swift
//  MovieDB
//
//  Created by Kel_Jellysh on 01/06/2021.
//

import Foundation

// array of movie per genre
struct List: Decodable {
    let listOf: [ListMovie]

    private enum CodingKeys: String, CodingKey {
        case listOf = "results"
    }

}
//element for each movie in array 
struct ListMovie: Decodable {
    
    let id: Int?
    let overview: String?
    let title: String?
    let releaseDate: String?
    let logoImage : String?
   
    enum CodingKeys: String, CodingKey {
        case id
        case overview
        case releaseDate = "release_date"
        case title
        case logoImage = "poster_path"
    }
}
