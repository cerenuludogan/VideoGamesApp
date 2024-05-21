//
//  AllGamesTableViewCell.swift
//  VideoGamesApp
//
//  Created by Ceren Uludoğan on 19.05.2024.
//

import UIKit
import Kingfisher

class AllGamesTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet private weak var releasedLabel: UILabel!
    @IBOutlet private weak var gameImageView: UIImageView!
    
    // @IBOutlet weak var detailLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func setupCell(game: GameItemViewModel) {
            // Set the game image using Kingfisher
            if let gameImageURL = game.gameImage {
                gameImageView.kf.setImage(with: gameImageURL, placeholder: UIImage(named: "defaultCoinImage"))
            } else {
                gameImageView.image = UIImage(named: "defaultCoinImage")
            }
            
            // Set the game name and release date
            nameLabel.text = game.name
            releasedLabel.text = game.released
        }
}
