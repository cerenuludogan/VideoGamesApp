//
//  DetailResponse.swift
//  VideoGamesApp
//
//  Created by Ceren Uludoğan on 24.05.2024.
//

import Foundation

struct DetailResponse: Codable {
    let id: Int
    let name: String
    let description: String
    let released: String?
    let backgroundImage: String?
    let rating: Double?

    enum CodingKeys: String, CodingKey {
        case id, name, description, released
        case backgroundImage = "background_image"
        case rating
    }
}
