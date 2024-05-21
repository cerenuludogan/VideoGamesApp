//
//  GameItemViewModel.swift
//  VideoGamesApp
//
//  Created by Ceren Uludoğan on 21.05.2024.
//

import Foundation
import Kingfisher

final class GameItemViewModel{
    private let game: GamesResultResponse
    
    init(game: GamesResultResponse) {
        self.game = game
    }
    
    var name: String{
        return game.name ?? ""
    }
    var released: String{
        return game.released ?? ""
    }
    var gameImage: URL? {
            if let urlString = game.iconUrl {
                return URL(string: urlString)
            }
            return nil
        }
    
}
    
