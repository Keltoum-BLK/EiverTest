//
//  ViewController.swift
//  MovieDB
//
//  Created by Kel_Jellysh on 01/06/2021.
//

import UIKit

class MovieViewController: UIViewController {



    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var originalTitle: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var overview: UITextView!
    
    
   
    var movieID: Int?
    var movie: MovieModel?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //GradientView
      
        print("MOVIEID ->", movieID ?? "")
        // Do any additional setup after loading the view.
        
      
        let ID = getIntToString(id: movieID)

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
        releaseDate.text = convertDateFormater(selectedMovie.releaseDate)
        backgroundImage.loadPoster(780, selectedMovie.posterPath ?? "no poster")
        
    }

    
    func convertDateFormater(_ date: String?) -> String {
            var fixDate = ""
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            if let originalDate = date {
                if let newDate = dateFormatter.date(from: originalDate) {
                    dateFormatter.dateFormat = "dd.MM.yyyy"
                    fixDate = dateFormatter.string(from: newDate)
                }
            }
            return fixDate
        }
    
    func getIntToString(id : Int?)-> (String) {
        //convert a Int? to String
        let ID = id.flatMap { String($0) }
        // unwrapped the optional with a guard let syntaxe
        guard let strData = ID else { return "aie" }
        return strData
    }
    
    func getToString(str: String?)-> (String) {
        //convert a Int? to String
        let str = readLine()
        // unwrapped the optional with a guard let syntaxe
        guard let strImage = str  else { return "" }
        return strImage
    }

}


