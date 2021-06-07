//
//  MovieCardViewController.swift
//  MovieDB
//
//  Created by Kel_Jellysh on 07/06/2021.
//

import UIKit

class MovieCardViewController: UIViewController {
    
    @IBOutlet weak var backPoster: UIImageView!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var originalTitle: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var overview: UITextView!
    //Back View
    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var viewOriginalTitle: UIView!
    @IBOutlet weak var viewDate: UIView!
    @IBOutlet weak var viewOverview: UIView!
    
    // variables toconnect to parse JsonData
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
        overview.text = selectedMovie.overview
        if overview.text == "" {
            overview.isHidden = true
            viewOverview.isHidden = true
        }
        date.text = selectedMovie.releaseDate
        backPoster.downloaded(from: "https://image.tmdb.org/t/p/w780\(selectedMovie.posterPath ?? "no poster")")
        backPoster.contentMode = .scaleToFill
        if selectedMovie.posterPath == nil {
            backPoster.image = UIImage(named: "affiche")
        }
        viewDate.layer.cornerRadius = 10
        viewTitle.layer.cornerRadius = 10
        viewOverview.layer.cornerRadius = 10
        viewOriginalTitle.layer.cornerRadius = 10
        viewTitle.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        viewOriginalTitle.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        viewDate.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        viewOverview.backgroundColor = UIColor.white.withAlphaComponent(0.7)
    }
    
    
    
    
}
