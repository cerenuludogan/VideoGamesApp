//
//  ViewController.swift
//  VideoGamesApp
//
//  Created by Ceren Uludoğan on 18.05.2024.
//

import UIKit

class GameViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private var homeView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    
    var viewModel = GameViewModel()
    lazy var games = viewModel.allGames
    lazy var filteredGame = [GamesResultResponse]()
    
    let searchController = UISearchController(searchResultsController: nil)
    var isSearchBarEmpty: Bool {
        searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
        searchController.isActive && !isSearchBarEmpty
    }

    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(cellType: TripleTableViewCell.self)
        tableView.register(cellType: AllGamesTableViewCell.self)
        
        searchController.searchBar.delegate = self
        
        viewModel.onDataUpdated = { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.fetchGameList()
    
        setupBackgroundImage()
        configureNavigationBar()
        configureSearchController()
        
    }
    // MARK: - Helper Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "toDetailVC" {
                if let destinationVC = segue.destination as? NewDetailController {
                    if let selectedGame = sender as? GamesResultResponse {
                        destinationVC.game = selectedGame
                    }
                }
            }
    }

    
    // MARK: - UI Setup
    
    private func setupBackgroundImage() {
        let backgroundImage = UIImage(named: "8")
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.frame = UIScreen.main.bounds
        backgroundImageView.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImageView, at: 0)
        
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = UIScreen.main.bounds
        blurEffectView.alpha = 0.3
        view.insertSubview(blurEffectView, aboveSubview: backgroundImageView)
        
        let tableBlurEffectView = UIVisualEffectView(effect: blurEffect)
        tableBlurEffectView.frame = tableView.bounds
        tableBlurEffectView.alpha = 0.3
        tableView.backgroundView = tableBlurEffectView
        tableView.backgroundColor = .clear
    }
    private func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    
        
    }

    private func configureSearchController() {
        searchController.searchBar.placeholder = "Search Games"
        searchController.searchBar.tintColor = .white
        searchController.obscuresBackgroundDuringPresentation = false
        
        navigationItem.searchController = searchController

        if let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField {
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
        searchController.searchBar.backgroundImage = UIImage()
        searchController.searchBar.isTranslucent = true
        searchController.searchBar.backgroundColor = .clear
    }

    private func filterContextForSearchText(_ searchText: String) {
         filteredGame = games.filter { game in
             let nameContains = game.name?.lowercased().contains(searchText.lowercased()) ?? false
             return nameContains
         }
         tableView.reloadData()
     }
}
     
// MARK: - UISearchBarDelegate

    extension GameViewController:UISearchBarDelegate {

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
                if searchText.count >= 3 {
                    filterContextForSearchText(searchText)
                } else {
                    filteredGame.removeAll()
                    tableView.reloadData()
                }
            }
       
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
                filteredGame.removeAll()
                tableView.reloadData()
            }
            
            func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
                filteredGame.removeAll()
                tableView.reloadData()
            }
        
}
    
// MARK: - UITableViewDataSource, UITableViewDelegate

extension GameViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.celltypeList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel.celltypeList[section] {
        case .tripleGame:
            return isFiltering ? 0 : 1
        case .allGamesCell:
            return isFiltering ? filteredGame.count : max(viewModel.allGames.count - 3, 0)

        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.celltypeList[indexPath.section] {
        case .tripleGame:
            let cell = tableView.dequeCell(cellType: TripleTableViewCell.self, indexPath: indexPath)
            let games = Array(viewModel.gameList)
            cell.setupCell(with: games)
            return cell
        case .allGamesCell:
            let cell = tableView.dequeCell(cellType: AllGamesTableViewCell.self, indexPath: indexPath)
            let game = viewModel.allGames[indexPath.row ] // İlk üç veriyi atla
            cell.setupCell(game: GameItemViewModel(game: game), index: indexPath.row + 1)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            
            if indexPath.section == viewModel.celltypeList.count - 1 && indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
                
                if viewModel.nextPage != nil {
                    viewModel.fetchGameList()
                }
            }
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch viewModel.celltypeList[indexPath.section] {
        case .tripleGame:
            break
        case .allGamesCell:
            let selectedGame = viewModel.allGames[indexPath.row]
            performSegue(withIdentifier: "toDetailVC", sender: selectedGame)
            print("Game tıklandı.")
            
        }
       
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            switch viewModel.celltypeList[indexPath.section] {
            case .tripleGame:
                return 150.0
            case .allGamesCell:
                return UITableView.automaticDimension
            }
        }
        
        func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
            return UIView()
        }
        
        func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return CGFloat.leastNormalMagnitude
        }
        
    }
}
