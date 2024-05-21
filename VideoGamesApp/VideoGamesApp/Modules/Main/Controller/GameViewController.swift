//
//  ViewController.swift
//  VideoGamesApp
//
//  Created by Ceren Uludoğan on 18.05.2024.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var homeView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel = GameViewModel()
    
    let searchController = UISearchController(searchResultsController: nil)
    lazy var games = viewModel.allGames
    lazy var filteredGame = [GamesResultResponse]()

    var isSearchBarEmpty: Bool {
        searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
        searchController.isActive && !isSearchBarEmpty
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableHeaderView = searchController.searchBar
        tableView.delegate = self
        tableView.dataSource = self
        configureSearchController()
        tableView.register(cellType: TripleTableViewCell.self)
        tableView.register(cellType: AllGamesTableViewCell.self)
        
        viewModel.onDataUpdated = { [weak self] in
        self?.tableView.reloadData()
        }
        
        navigationController?.navigationBar.backgroundColor = .clear
           
        
        let backgroundImage = UIImage(named: "8")
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.frame = homeView.bounds
        backgroundImageView.contentMode = .scaleAspectFill
        homeView.insertSubview(backgroundImageView, at: 0)
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = homeView.bounds
        blurEffectView.alpha = 0.9
        backgroundImageView.addSubview(blurEffectView)
        tableView.backgroundView = backgroundImageView
        tableView.backgroundColor = .clear

        viewModel.fetchGameList()
    }
    
    private func filterContextForSearchText(_ searchText: String) {
        filteredGame = games.filter { game in
            let nameContains = game.name?.lowercased().contains(searchText.lowercased()) ?? false
            return nameContains
        }
        tableView.reloadData()
    }
    private func configureSearchController() {
        searchController.searchBar.placeholder = "Search Games"
        searchController.searchBar.backgroundColor = .clear
        searchController.searchBar.barTintColor = .clear
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController

        if let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textFieldInsideSearchBar.backgroundColor = UIColor(hex: "#71577D")
            textFieldInsideSearchBar.textColor = .white
            if let placeholder = textFieldInsideSearchBar.placeholder {
                textFieldInsideSearchBar.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            }

            if let searchIcon = UIImage(systemName: "magnifyingglass")?.withRenderingMode(.alwaysTemplate) {
                let iconView = UIImageView(image: searchIcon)
                iconView.tintColor = .white
                textFieldInsideSearchBar.leftView = iconView
                textFieldInsideSearchBar.leftViewMode = .always
            }
        }

    }


    

}

extension GameViewController: UISearchResultsUpdating{
   
    func updateSearchResults(for searchController: UISearchController) {
            let searchBar = searchController.searchBar
            filterContextForSearchText(searchBar.text ?? "")
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
                 return isFiltering ? filteredGame.count : viewModel.allGames.count
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
                return 150.0
            case .allGamesCell:
                return UITableView.automaticDimension
            }
        }
   
    
}


