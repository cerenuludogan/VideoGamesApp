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
    
    var celltypeList: [GameTableCellType] = []
    private var gameList: [GamesResultResponse] = []
    var allGames: [GamesResultResponse] = []
    
    var onDataUpdated: (() -> Void)?
    
    func fetchGameList() {
        ServiceManager.shared.getAllGames { [weak self] gameResponse in
            guard let self = self else { return }
            if let gameResponse = gameResponse, let games = gameResponse.results {
                self.gameList = games
                self.allGames = games
                self.celltypeList.append(.tripleGame)
                self.celltypeList.append(.allGamesCell)
                self.onDataUpdated?() 
            } else {
                print("GameResponse is nil.")
            }
        }
    }
}
