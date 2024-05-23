//
//  ViewController.swift
//  VideoGamesApp
//
//  Created by Ceren Uludoğan on 18.05.2024.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet private var homeView: UIView!
    @IBOutlet private weak var tableView: UITableView!
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
     //   configureTabBar()
        configureSearchController()
        
    }
    
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
 /*   private func configureTabBar() {
        guard let tabBar = tabBarController?.tabBar else { return }
    
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.isTranslucent = true
        tabBar.backgroundColor = .clear
        

        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = tabBar.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0.3
        tabBar.insertSubview(blurEffectView, at: 0)
        
        if let items = tabBar.items {
            for item in items {
                item.image = item.image?.withRenderingMode(.alwaysTemplate)
                item.selectedImage = item.selectedImage?.withRenderingMode(.alwaysTemplate)
                item.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
                item.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
            }
        }
    }*/
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
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                if segue.identifier == "toDetailVC" {
                    if let destinationVC = segue.destination as? DetailViewController {
                        if let selectedGame = sender as? GamesResultResponse {
                            destinationVC.game = selectedGame
                        }
                    }
                }
            }
        
}
    
    
extension GameViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.celltypeList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel.celltypeList[section] {
        case .tripleGame:
            return isFiltering ? 0 : 1
        case .allGamesCell:
            return isFiltering ? filteredGame.count : viewModel.allGames.count//isFiltering ? filteredGame.count :
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.celltypeList[indexPath.section] {
        case .tripleGame:
            let cell = tableView.dequeCell(cellType: TripleTableViewCell.self, indexPath: indexPath)
            let games = Array(viewModel.allGames.prefix(3))
            cell.setupCell(with: games)
            return cell
        case .allGamesCell:
            let cell = tableView.dequeCell(cellType: AllGamesTableViewCell.self, indexPath: indexPath)
            let game = viewModel.allGames[indexPath.row]
            cell.setupCell(game: GameItemViewModel(game: game))
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch viewModel.celltypeList[indexPath.section] {
        case .tripleGame:
            break
        case .allGamesCell:
            let selectedGame = viewModel.allGames[indexPath.row]
            performSegue(withIdentifier: "toDetailVC", sender: selectedGame)
            print("Tüm paralar tıklandı.")
            // Diğer case'ler
            
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
