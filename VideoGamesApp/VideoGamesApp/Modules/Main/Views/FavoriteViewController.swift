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
}
