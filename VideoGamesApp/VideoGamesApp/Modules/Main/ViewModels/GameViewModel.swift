//
//  GameViewModel.swift
//  VideoGamesApp
//
//  Created by Ceren Uludoğan on 20.05.2024.
//

import Foundation

final class GameViewModel {
    
    enum GameTableCellType {
        case tripleGame
        case allGamesCell
    
    }
    var nextPage: String?
    var celltypeList: [GameTableCellType] = []
    var gameList: [GamesResultResponse] = []
    var allGames: [GamesResultResponse] = []
    
    var onDataUpdated: (() -> Void)?

    func fetchGameList() {
        ServiceManager.shared.getAllGames(nextPage: nextPage) { [weak self] gameResponse in
            guard let self = self else { return }
            if let gameResponse = gameResponse,
               let games = gameResponse.results {
                allGames.append(contentsOf: games)
                nextPage = gameResponse.next
                if celltypeList.isEmpty {
                    gameList = Array(games.prefix(3))
                    celltypeList.append(.tripleGame)
                    celltypeList.append(.allGamesCell)
                }
                onDataUpdated?()
            } else {
                print("GameResponse is nil.")
            }
        }
    }
}
