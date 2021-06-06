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
        
        //service
        let ID = getIntToString(id: genderId)
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
    
    
}


//MARK: - Delegation
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = listArray?[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //  Verification Optionnel
        guard let gendersListCount = listArray?.count else {return 1}
        return gendersListCount
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let moviesVC = storyboard.instantiateViewController(identifier: "movieVC") as! MovieViewController
        moviesVC.movieID = listArray![indexPath.row].id
        self.present(moviesVC, animated: true, completion: nil)
    }

    

}



