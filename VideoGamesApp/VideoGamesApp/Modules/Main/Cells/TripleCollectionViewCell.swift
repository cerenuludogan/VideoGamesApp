//
//  TripleCollectionViewCell.swift
//  VideoGamesApp
//
//  Created by Ceren Uludoğan on 19.05.2024.
//

import UIKit
import Kingfisher
class TripleCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var gameImageView: UIImageView!
 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(game: GameItemViewModel) {
            // Set the game image using Kingfisher
            if let gameImageURL = game.gameImage {
                gameImageView.kf.setImage(with: gameImageURL, placeholder: UIImage(named: "defaultCoinImage"))
            } else {
                gameImageView.image = UIImage(named: "defaultCoinImage")
            }
            
           
        }
}
