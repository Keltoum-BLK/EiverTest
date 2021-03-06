//
//  ListViewController.swift
//  MovieDB
//
//  Created by Kel_Jellysh on 06/06/2021.
//

import UIKit

class ListViewController: UIViewController {
   //MARK: VARIABLES AND UIBoutlet
    //Connected UI
    @IBOutlet weak var tableView: UITableView!
    
    //variables used to parse Data to UI
    var genderId: Int?
    private var listArray: [ListMovie]?
    private var titlemovie : ListMovie?
    private var genre : GenreModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        setUpTableView()
        //cast ID Optionnal to String
        let ID = Tool.shared.getIntToString(id: genderId)
        //call API method to parse the data to UI
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
    //connect XIB to controller 
    private func setUpTableView() {
        tableView.register(UINib(nibName: "MovieViewCell", bundle: nil), forCellReuseIdentifier: "MovieViewCell")
    }
}

//MARK: - Delegation
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //parse Data to UICustomCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieViewCell", for: indexPath) as! MovieViewCell
        cell.titleMovie.text = listArray?[indexPath.row].title
        if listArray?[indexPath.row].logoImage == nil {
            cell.logoMovie.image = UIImage(named: "affiche")
            cell.logoMovie.contentMode = .scaleAspectFit
        }
        //convert data to UIImage
        cell.logoMovie.downloaded(from: "https://image.tmdb.org/t/p/w185\(listArray?[indexPath.row].logoImage ?? "no image")")
        cell.releaseDateMovie.text = Tool.shared.convertDateFormater(listArray?[indexPath.row].releaseDate)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //  Verification Optionnel
        guard let gendersListCount = listArray?.count else {return 1}
        return gendersListCount
    }
    //push variable to be used in another viewController
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieVC = MovieCardViewController(nibName: "MovieCardViewController", bundle: nil)
        movieVC.movieID = listArray?[indexPath.row].id
        self.present(movieVC, animated: true, completion: nil)
    }
    //block height of the cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
}



