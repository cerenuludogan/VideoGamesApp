//
//  AllGamesTableViewCell.swift
//  VideoGamesApp
//
//  Created by Ceren Uludoğan on 19.05.2024.
//

import UIKit
import Kingfisher

class AllGamesTableViewCell: UITableViewCell {

    @IBOutlet private weak var addedLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var gameImageView: UIImageView!
    @IBOutlet private weak var releasedLabel: UILabel!
 
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
                
    }
    func setupCell(game: GameItemViewModel) {
        nameLabel.text = game.name
        releasedLabel.text = game.released
        addedLabel.text = String(game.added)
        ratingLabel.attributedText = createRatingText(with: game.rating)
        addedLabel.attributedText = createAddedText(with: game.added)
        
        if let gameImageURL = game.gameImage {
            gameImageView.kf.setImage(with: gameImageURL, placeholder: UIImage(named: "defaultCoinImage"))
            } else {
                gameImageView.image = UIImage(named: "defaultCoinImage")
            }
    }
          
          private func createRatingText(with rating: Double) -> NSAttributedString {
              let starImageAttachment = NSTextAttachment()
              starImageAttachment.image = UIImage(systemName: "star.fill")?.withTintColor(.yellow, renderingMode: .alwaysOriginal)
              let imageOffsetY: CGFloat = -2.0
              starImageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: 14, height: 14)
              let starAttributedString = NSAttributedString(attachment: starImageAttachment)
              let ratingString = String(format: " %.1f", rating)
              let ratingAttributedString = NSAttributedString(string: ratingString)
              let combinedAttributedString = NSMutableAttributedString()
              combinedAttributedString.append(starAttributedString)
              combinedAttributedString.append(ratingAttributedString)
              return combinedAttributedString
          }
    
    private func createAddedText(with count: Int) -> NSAttributedString {
            let downloadImageAttachment = NSTextAttachment()
            downloadImageAttachment.image = UIImage(systemName: "arrow.down.to.line.alt")?.withTintColor(.white, renderingMode: .alwaysOriginal)
            let imageOffsetY: CGFloat = -2.0
            downloadImageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: 14, height: 14)
            let downloadAttributedString = NSAttributedString(attachment: downloadImageAttachment)
            let countString = "\(count)"
            let countAttributedString = NSAttributedString(string: countString)
            let combinedAttributedString = NSMutableAttributedString()
            combinedAttributedString.append(downloadAttributedString)
            combinedAttributedString.append(NSAttributedString(string: " "))
            combinedAttributedString.append(countAttributedString)
            
            return combinedAttributedString
        }
}
