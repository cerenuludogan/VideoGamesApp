////
////  FavoriteManager.swift
////  VideoGamesApp
////
////  Created by Ceren Uludoğan on 24.05.2024.
//////
import Foundation

final class FavoriteManager {
    static let shared = FavoriteManager()
    private init() { }
    
    var favoriteGames: [DetailResponse] = []
    
    func addFavoriteGame(_ game: DetailResponse) {
        if !favoriteGames.contains(where: { $0.id == game.id }) {
            favoriteGames.append(game)
        }
    }
    
    func removeFavoriteGame(_ game: DetailResponse) {
        
        if let index = favoriteGames.firstIndex(where: { $0.id == game.id }) {
            favoriteGames.remove(at: index)
        }
    }
}
