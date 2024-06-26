//
//  GameResponse.swift
//  VideoGamesApp
//
//  Created by Ceren Uludoğan on 19.05.2024.
//

import Foundation

struct GameResponse: Decodable {
    let next: String?
    let results: [GamesResultResponse]?
}

struct GamesResultResponse: Decodable {
    let id: Int?
    let name: String?
    let released: String?
    let iconUrl: String?
    let rating: Double?
    let added: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case released
        case iconUrl = "background_image"
        case rating
        case added
    }
}
