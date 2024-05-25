//
//  FavoriteViewController.swift
//  VideoGamesApp
//
//  Created by Ceren Uludoğan on 25.05.2024.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    // MARK: - Properties
    
    var detail: DetailResponse?
    var favoriteGames: [DetailResponse] = []

    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        registerCell()
       
        if let detail = detail {
            favoriteGames.append(detail)
        }
    }
    
    // MARK: - Helper Methods
    
    func registerCell(){
        tableView.register(cellType: FavoriteTableViewCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoriteGames = FavoriteManager.shared.favoriteGames
        tableView.reloadData()
    }
  
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteGames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeCell(cellType: FavoriteTableViewCell.self, indexPath: indexPath)
        let game = favoriteGames[indexPath.row]
        cell.setupCell(detail: game)
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deletedGame = favoriteGames[indexPath.row]
            let alertController = UIAlertController(title: "Delete Game", message: "Are you sure you want to delete this game?", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
                guard let self = self else { return }
                // Favori yöneticisinden favori oyunu kaldır
                FavoriteManager.shared.removeFavoriteGame(deletedGame)
                // Tabloyu güncelle
                self.favoriteGames.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
            alertController.addAction(cancelAction)
            alertController.addAction(deleteAction)
            
            present(alertController, animated: true, completion: nil)
        }
    }
}
