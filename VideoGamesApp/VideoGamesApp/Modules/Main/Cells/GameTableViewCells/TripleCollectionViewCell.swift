//
//  TripleCollectionViewCell.swift
//  VideoGamesApp
//
//  Created by Ceren Uludoğan on 19.05.2024.
//

import UIKit
import Kingfisher
class TripleCollectionViewCell: UICollectionViewCell {
    // MARK: - Outlets
    @IBOutlet private weak var gameImageView: UIImageView!
 
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func setupCell(game: GameItemViewModel) {
        
        if let gameImageURL = game.gameImage {
            gameImageView.kf.setImage(with: gameImageURL, placeholder: UIImage(named: "defaultCoinImage"))
            } else {
                gameImageView.image = UIImage(named: "defaultCoinImage")
            }
    }
}
