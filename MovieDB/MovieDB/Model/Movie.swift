//
//  Movie.swift
//  MovieDB
//
//  Created by Kel_Jellysh on 06/06/2021.
//

import Foundation

//struct MovieModel
struct MovieModel: Decodable {
    var id: Int?
    var originalTitle: String?
    var overview: String?
    var posterPath: String?
    var releaseDate: String?
    var title: String?
 
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case originalTitle = "original_title"
        case overview = "overview"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title = "title"
      
    }
}
