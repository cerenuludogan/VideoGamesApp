//
//  TexViewController.swift
//  VideoGamesApp
//
//  Created by Ceren Uludoğan on 24.05.2024.
//

import UIKit

class NewDetailController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    var viewModel: DetailViewModel?
    lazy var details = viewModel?.gameDetailList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        registerCells()
    }
    
    private func registerCells() {
        tableView.register(cellType: ImageTableViewCell.self)
        tableView.register(cellType: SymbolTableViewCell.self)
        tableView.register(cellType: ButtonTableViewCell.self)
        tableView.register(cellType: TextTableViewCell.self)
    }
}

extension NewDetailController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.celltypeList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let celltypeList = viewModel?.celltypeList else { return 0 }
        switch celltypeList[section] {
        case .headerImage, .info, .action, .description:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let celltypeList = viewModel?.celltypeList else { return UITableViewCell() }
        switch celltypeList[indexPath.section] {
        case .headerImage:
            let cell = tableView.dequeCell(cellType: ImageTableViewCell.self, indexPath: indexPath)
            // Header görüntüsünü ayarla
            return cell
        case .info:
            let cell = tableView.dequeCell(cellType: SymbolTableViewCell.self, indexPath: indexPath)
            cell.setupCell(detailResponse: viewModel?.detailResponse)
            return cell
        case .action:
            let cell = tableView.dequeCell(cellType: ButtonTableViewCell.self, indexPath: indexPath)
            // Butonları ayarla
            return cell
        case .description:
            let cell = tableView.dequeCell(cellType: TextTableViewCell.self, indexPath: indexPath)
            // Açıklamayı ayarla
            return cell
        }
    }
}

