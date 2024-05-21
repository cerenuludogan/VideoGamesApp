//
//  ViewController.swift
//  VideoGamesApp
//
//  Created by Ceren Uludoğan on 18.05.2024.
//

import UIKit

class GameViewController: UIViewController {

 
    @IBOutlet weak var tableView: UITableView!
    var viewModel = GameViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: TripleTableViewCell.self)
        tableView.register(cellType: AllGamesTableViewCell.self)
        
        viewModel.onDataUpdated = { [weak self] in
        self?.tableView.reloadData()
        }
                
        viewModel.fetchGameList()
    }
    
}

extension GameViewController: UITableViewDataSource, UITableViewDelegate{

    
    func numberOfSections(in tableView: UITableView) -> Int {
           return viewModel.celltypeList.count
       }
    
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           switch viewModel.celltypeList[section] {
           case .tripleGame:
               return 1
           case .allGamesCell:
               return viewModel.allGames.count
           }
       }
       
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            switch viewModel.celltypeList[indexPath.section] {
            case .tripleGame:
                        let cell = tableView.dequeCell(cellType: TripleTableViewCell.self, indexPath: indexPath)
                        let games = Array(viewModel.allGames.prefix(3)) // İlk üç oyunu kullan
                        cell.setupCell(with: games)
                        return cell
            case .allGamesCell:
                let cell = tableView.dequeCell(cellType: AllGamesTableViewCell.self, indexPath: indexPath)
                let game = viewModel.allGames[indexPath.row]
                cell.setupCell(game: GameItemViewModel(game: game))
                return cell
            }
        }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            switch viewModel.celltypeList[indexPath.section] {
            case .tripleGame:
                return 200.0
            case .allGamesCell:
                return UITableView.automaticDimension
            }
        }
    
}


