//
//  ListViewCell.swift
//  MovieDB
//
//  Created by Kel_Jellysh on 06/06/2021.
//

import UIKit

class ListViewCell: UITableViewCell {

    
    
    @IBOutlet weak var cell: UIView!
    @IBOutlet weak var posterMovie: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var descMovie: UITextView!
    
    
    func setup(_ movie: ListMovie) {
        contentView.layer.cornerRadius = 10
        titleMovie.text = movie.title
        date.text = convertDateFormater(movie.releaseDate)
        descMovie.text = movie.overview
        posterMovie.downloaded(from: "https://image.tmdb.org/t/p/w92\(String(describing: movie.logoImage))")    }
    
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
}

//extension UIImageView {
//
//    func loadPoster(_ size: Int, _ path: String) {
//        let urlString = "https://image.tmdb.org/t/p/w\(size)\(path)"
//        guard let url = URL(string: urlString) else { return }
//        URLSession.shared.dataTask(with: url) { (d, _, _) in
//            DispatchQueue.main.async {
//                if let data = d {
//                    self.image = UIImage(data: data)
//
//                }
//            }
//        }.resume()
//    }
//
//}
