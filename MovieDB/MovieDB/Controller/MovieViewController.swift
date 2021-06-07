//
//  ViewController.swift
//  MovieDB
//
//  Created by Kel_Jellysh on 01/06/2021.
//

import UIKit

class MovieViewController: UIViewController {
    
    var movieID: Int?
    var movie: MovieModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MOVIEID ->", movieID ?? "")
        
        
        
        let ID = Tool.shared.getIntToString(id: movieID)
        
        ApiManager.shared.getMovieDetails(movieID: ID, completionHandler: { result in
            switch result {
            case .success(let use):
                // guard let movie = use else { return }
                DispatchQueue.main.async {
                    self.movie = use
                    self.setUp()
                }
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        })
        
    }
    
    
    func setUp(){
        guard let selectedMovie = movie else { return }
        titleMovie.text = selectedMovie.title
        originalTitle.text = selectedMovie.originalTitle
        if selectedMovie.overview != ""{
            overview.text = selectedMovie.overview
        } else {
            overview.isHidden = true
        }
        releaseDate.text = Tool.shared.convertDateFormater(selectedMovie.releaseDate)
        backgroundImage.downloaded(from: "https://image.tmdb.org/t/p/w780\(selectedMovie.posterPath ?? "no poster")")
        backgroundImage.contentMode = .scaleToFill
        overview.layer.cornerRadius = 10
        releaseDate.layer.cornerRadius = 10
        titleMovie.layer.cornerRadius = 10
        originalTitle.layer.cornerRadius = 10
        viewTest.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        viewTest.layer.cornerRadius = 10
       
    }
 
}


