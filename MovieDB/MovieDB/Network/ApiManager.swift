//
//  MovieService.swift
//  MovieDB
//
//  Created by Kel_Jellysh on 01/06/2021.
//

import Foundation

class ApiManager {
    
    //MARK: Variables and initialisation of singleton pattern
    //variables used
    private var dataTask: URLSessionDataTask?
    let API_KEY = "cbeeec9e018e2e054c87e1aac9a2a5c2"
    
    //creation of a singleton partern to use it in all module
    static let shared = ApiManager()
    
    //MARK: Enum to definite error cases
    enum NetworkError: Error {
        case badUrl
        case invalidData
        case network
    }
    
    //MARK: Fletch data
    // API Call to parse data movie
    func getMovieDetails(movieID: String, completionHandler: @escaping (Result<MovieModel, Error>) -> Void) {
        
        let movieURL = "https://api.themoviedb.org/3/movie/\(movieID)?api_key=\(API_KEY)&language=fr-FR"
        
        
        guard let url = URL(string: movieURL) else { return }
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completionHandler(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                return
            }
            
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                print("Emplty Data")
                return
            }
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MovieModel.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(.success(jsonData))
                }
            } catch let error {
                completionHandler(.failure(error))
            }
        }
        dataTask?.resume()
        
    }
    // API Call to parse data list of movie per genre
    func getListOfMoviesGender(genreID: String, completionHandler: @escaping (Result<List, Error>) -> Void) {
        
        let moviesGenderURL =
            "https://api.themoviedb.org/3/discover/movie?api_key=\(API_KEY)&language=fr-FR&include_adult=false&include_video=false&page=1&with_genres=\(String(describing: genreID))"
        
        guard let url = URL(string: moviesGenderURL) else { return }
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completionHandler(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                return
            }
            
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                print("Emplty Data")
                return
            }
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(List.self, from: data)
                
                DispatchQueue.main.async {
                    completionHandler(.success(jsonData))
                }
            } catch let error {
                completionHandler(.failure(error))
            }
        }
        dataTask?.resume()
    }
    // API Call to parse data list of genre
    func getGenre(completionHandler: @escaping (Result <Genre, NetworkError>) -> Void) {
        guard let moviesUrl = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=\(API_KEY)&language=fr-FR") else { return }
        
        dataTask = URLSession.shared.dataTask(with: moviesUrl) { (data, response, error) in
            DispatchQueue.main.async {
                //unwrap data response and error to manage error cases and success 
                if error != nil {
                    completionHandler(.failure(.badUrl))
                    return
                }
                guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completionHandler(.failure(.network))
                    return
                }
                // lecture JSON
                guard let object = try? JSONDecoder().decode(Genre.self, from: data) else {
                    completionHandler(.failure(.invalidData))
                    return
                }
                completionHandler(.success(object))
            }
        }
        dataTask?.resume()
    }
}

