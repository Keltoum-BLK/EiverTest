//
//  ExtensionUIImage.swift
//  MovieDB
//
//  Created by Kel_Jellysh on 07/06/2021.
//

import Foundation
import UIKit

extension UIImageView {
    
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
            contentMode = mode
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                    else { return }
                DispatchQueue.main.async() {
                    self.image = image
                }
            }.resume()
        }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
            guard let url = URL(string: link) else { return }
            downloaded(from: url, contentMode: mode)
        print(url)
        }
    
    func loadPoster(_ size: Int, _ path: String) {
        let urlString = "https://image.tmdb.org/t/p/w780\(path)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (d, _, _) in
            DispatchQueue.main.async {
                if let data = d {
                    self.image = UIImage(data: data)

                }
            }
        }.resume()
    }
//
//    func loadLogo( path: String) {
//        let urlString = "https://image.tmdb.org/t/p/w92\(path)"
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

}

