//
//  ListViewController.swift
//  MovieDB
//
//  Created by Kel_Jellysh on 06/06/2021.
//

import UIKit

class ListViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var genderId: Int?
    private var listArray: [ListMovie]?
    private var titlemovie : ListMovie?
    private var genre : GenreModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Genre ->", genderId ?? "")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        setUpTableView()
        //service
        let ID = Tool.shared.getIntToString(id: genderId)
        print(ID)
        ApiManager.shared.getListOfMoviesGender(genreID: ID) {  result in
            switch result {
            case .success(let use):
                DispatchQueue.main.async {
                    self.listArray = use.listOf
                    self.tableView.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func setUpTableView() {
        tableView.register(UINib(nibName: "MovieViewCell", bundle: nil), forCellReuseIdentifier: "MovieViewCell")
    }
    
 
    
    
}


//MARK: - Delegation
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieViewCell", for: indexPath) as! MovieViewCell
        cell.titleMovie.text = listArray?[indexPath.row].title
        cell.logoMovie.downloaded(from: "https://image.tmdb.org/t/p/w185\(listArray?[indexPath.row].logoImage ?? "no image")")
        cell.releaseDateMovie.text = Tool.shared.convertDateFormater(listArray?[indexPath.row].releaseDate)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //  Verification Optionnel
        guard let gendersListCount = listArray?.count else {return 1}
        return gendersListCount
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
//        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let moviesVC = storyboard.instantiateViewController(identifier: "movieVC") as! MovieViewCardController
        let movieVC = MovieCardViewController(nibName: "MovieCardViewController", bundle: nil)
        movieVC.movieID = listArray?[indexPath.row].id
        self.present(movieVC, animated: true, completion: nil)
    }

    

}



