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
    let overview: String?
    let title: String?
    let releaseDate: String?
    let logoImage : String?
   

   
    enum CodingKeys: String, CodingKey {
        case id
        case overview
        case releaseDate = "release_date"
        case title
        case logoImage = "logo_path"
    }
}

//{
//    "page": 1,
//    "results": [
//        {
//            "adult": false,
//            "backdrop_path": "/77tui163estZrQ78NBggqDB4n2C.jpg",
//            "genre_ids": [
//                28,
//                80
//            ],
//            "id": 637649,
//            "original_language": "en",
//            "original_title": "Wrath of Man",
//            "overview": "Un convoyeur de fond, fraîchement engagé, surprend ses collègues par l’incroyable précision de ses tirs de riposte, alors qu’ils subissent les assauts de braqueurs expérimentés. Tous se demandent désormais qui il est, d’où il vient et pourquoi il est là.",
//            "popularity": 4051.301,
//            "poster_path": "/u1xYjmCpDqgUfLlSgq8HlHtVVor.jpg",
//            "release_date": "2021-04-22",
//            "title": "Un homme en colère",
//            "video": false,
//            "vote_average": 7.9,
//            "vote_count": 673
//        },
