//
//  List.swift
//  MyMovieTestTech
//
//  Created by Kel_Jellysh on 06/06/2021.
//

import Foundation

//MARK: List of Movies

struct List: Decodable {
    let listOfMovies: [ListMovie]
    
    enum CodingKeys: String, CodingKey {
        
        case listOfMovies = "results"
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
