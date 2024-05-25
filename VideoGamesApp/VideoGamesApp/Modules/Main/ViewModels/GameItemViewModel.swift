//
//  GameItemViewModel.swift
//  VideoGamesApp
//
//  Created by Ceren Uludoğan on 21.05.2024.
//

import Foundation


final class GameItemViewModel{
    
    private let game: GamesResultResponse
    
    init(game: GamesResultResponse) {
        self.game = game
    }
    
    var name: String{
        return game.name ?? ""
    } 
    var rating: Double{
        return game.rating ?? 0.0
    }
    var released: String{
        return game.released ?? ""
    }
    var added: Int{
        return game.added ?? 0
    }
    var gameImage: URL? {
            if let urlString = game.iconUrl {
                return URL(string: urlString)
            }
            return nil
        }
    
}
    
