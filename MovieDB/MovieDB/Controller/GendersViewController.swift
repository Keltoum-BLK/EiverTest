//
//  GendersViewController.swift
//  MovieDB
//
//  Created by Kel_Jellysh on 03/06/2021.
//

import UIKit

class GendersViewController: UIViewController {
    
    //MARK: IBoutlet and variables
    @IBOutlet weak var genderTableView: UITableView!
    
    private var genderArray: [GenreModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        genderTableView.delegate = self
        genderTableView.dataSource = self
        // call of Api to parse data in variables and refresh values in tab
        ApiManager.shared.getGenre { result in
            switch result {
            case .success(let gender):
                DispatchQueue.main.async {
                    self.genderArray = gender.genres
                    self.genderTableView.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
//MARK: Delegations
extension GendersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //assign a value to tabview cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Cast de la fonction
        let cell = UITableViewCell()
        cell.textLabel?.text = genderArray![indexPath.row].name
        return cell
    }
    //assign number of element in the tabview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //  Verification Optionnel
        guard let gendersCount = genderArray?.count else {return 0}
        return gendersCount
    }
    //push variable to be used in another viewController
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let moviesVC = storyboard.instantiateViewController(identifier: "listVC") as! ListViewController
        moviesVC.genderId = genderArray![indexPath.row].id
        self.navigationController?.pushViewController(moviesVC, animated: true)
    }
}
