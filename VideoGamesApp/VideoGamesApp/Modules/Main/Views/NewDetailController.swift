//
//  TexViewController.swift
//  VideoGamesApp
//
//  Created by Ceren Uludoğan on 24.05.2024.
//

import UIKit

class NewDetailController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet private weak var tableView: UITableView!
    var game: GamesResultResponse?
    var viewModel = DetailViewModel()
   
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        registerCells()
        configureTabbar()
        
        if let game = game {
            viewModel.fetchGameDetails(id: game.id!)
        }
        
        viewModel.onDetailFetched = { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
    
    // MARK: Helper -  Private Methods
    private func configureTabbar(){
        self.tabBarController?.tabBar.setBackgroundColor(hexColor: "#2E244D")

    }
    
    private func registerCells() {
        tableView.register(cellType: ImageTableViewCell.self)
        tableView.register(cellType: SymbolTableViewCell.self)
        tableView.register(cellType: ButtonTableViewCell.self)
        tableView.register(cellType: TextTableViewCell.self)
        tableView.register(cellType: WatchButtonTableViewCell.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFavoriteVC" {
            if let destinationVC = segue.destination as? FavoriteViewController {
                if let selectedGame = sender as? DetailResponse {
                    destinationVC.detail = selectedGame
                }
            }
        }
    }
    // MARK:
    
    private func heightForText(_ text: String, width: CGFloat, font: UIFont) -> CGFloat {
        let size = CGSize(width: width, height: .greatestFiniteMagnitude)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(estimatedFrame.height)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension NewDetailController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.celltypeList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let celltypeList = viewModel.celltypeList
        switch celltypeList[section] {
        case .headerImage, .info, .action, .description, .watch:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.celltypeList[indexPath.section] {
        case .headerImage:
            let cell = tableView.dequeCell(cellType: ImageTableViewCell.self, indexPath: indexPath)
            cell.setupCell(detail: viewModel.detailResponse!)
            return cell
        case .info:
            let cell = tableView.dequeCell(cellType: SymbolTableViewCell.self, indexPath: indexPath)
            cell.setupCell(detailResponse: viewModel.detailResponse)
            return cell
        case .action:
            let cell = tableView.dequeCell(cellType: ButtonTableViewCell.self, indexPath: indexPath)
            cell.likeButtonAction = { [weak self] in
                guard let self = self else { return }
                if let selectedGame = self.viewModel.detailResponse {
                    // Favori oyunları listesine ekleyin
                    FavoriteManager.shared.addFavoriteGame(selectedGame)
                    self.tableView.reloadData()
                    // Favori ekranına geçiş yapın
                    self.performSegue(withIdentifier: "toFavoriteVC", sender: selectedGame)
                }
            }
            return cell


        case .description:
            let cell = tableView.dequeCell(cellType: TextTableViewCell.self, indexPath: indexPath)
            cell.setupCell(detailViewModel: viewModel)
            return cell
        case .watch:
            let cell = tableView.dequeCell(cellType: WatchButtonTableViewCell.self, indexPath: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch viewModel.celltypeList[indexPath.section] {
        case .headerImage:
            return 200.0
        case .info:
            return 70
        case .action:
            return 70
        case .description:
            if let descriptionText = viewModel.detailResponse?.description {
                return heightForText(descriptionText, width: tableView.bounds.width - 16, font: UIFont.systemFont(ofSize: 14)) + 16
            } else {
                return UITableView.automaticDimension
            }
        case .watch:
            return UITableView.automaticDimension
        }
    }
}
extension NewDetailController {
    func addFavoriteGame(_ game: DetailResponse) {
        FavoriteManager.shared.addFavoriteGame(game)
        // Favori eklendiğinde kullanıcıya bildirim gösterebilir veya başka bir işlem yapabilirsiniz.
    }
}
