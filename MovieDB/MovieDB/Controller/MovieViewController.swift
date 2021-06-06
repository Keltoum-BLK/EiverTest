//
//  ViewController.swift
//  MovieDB
//
//  Created by Kel_Jellysh on 01/06/2021.
//

import UIKit

class MovieViewController: UIViewController {



    
    @IBOutlet weak var bg: UIView!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var originalTitle: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var overview: UITextView!
    @IBOutlet weak var rateNote: UILabel!
    
   
    var movieID: Int?
    var movie: MovieModel?
    var movieBy = MovieModel()

    
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
       releaseDate.text = selectedMovie.releaseDate
        
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIImageView {

    func download(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let imageData = data, let image = UIImage(data: imageData) else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
    
}
