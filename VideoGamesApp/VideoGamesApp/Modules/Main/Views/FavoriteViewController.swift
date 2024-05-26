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
    private let backgroundImageView = UIImageView()
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        registerCell()
        configureBackground()
       
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
    private func configureBackground(){
        let backgroundImageView = UIImageView(image: UIImage(named: "8"))
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        tableView.backgroundView = backgroundImageView
               
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.addSubview(blurEffectView)
               
        NSLayoutConstraint.activate([
        blurEffectView.leadingAnchor.constraint(equalTo:backgroundImageView.leadingAnchor),
        blurEffectView.trailingAnchor.constraint(equalTo:backgroundImageView.trailingAnchor),
        blurEffectView.topAnchor.constraint(equalTo:backgroundImageView.topAnchor),
        blurEffectView.bottomAnchor.constraint(equalTo:backgroundImageView.bottomAnchor)
               ])
        blurEffectView.alpha = 0.5
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
                FavoriteManager.shared.removeFavoriteGame(deletedGame)
                self.favoriteGames.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            alertController.addAction(cancelAction)
            alertController.addAction(deleteAction)
            
            present(alertController, animated: true, completion: nil)
        }
    }
}
