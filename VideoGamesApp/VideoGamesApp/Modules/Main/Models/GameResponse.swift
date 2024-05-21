//
//  GameResponse.swift
//  VideoGamesApp
//
//  Created by Ceren Uludoğan on 19.05.2024.
//

import Foundation


struct GameResponse: Decodable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [GamesResultResponse]?
}

struct GamesResultResponse: Decodable {
    let id: Int?
    let name: String?
    let released: String?
    let iconUrl: String?
    let rating: Double?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case released
        case iconUrl = "background_image"
        case rating
    }
}
