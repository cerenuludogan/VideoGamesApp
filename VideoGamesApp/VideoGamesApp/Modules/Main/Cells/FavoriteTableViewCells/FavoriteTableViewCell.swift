//
//  FavoriteTableViewCell.swift
//  VideoGamesApp
//
//  Created by Ceren Uludoğan on 25.05.2024.
//

import UIKit
import Kingfisher

class FavoriteTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var releasedLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var gameImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    // MARK: - Lifecycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
                self.contentView.backgroundColor = .clear
                
            

    }
    
    // MARK: - Public Methods
    
    func setupCell(detail: DetailResponse) {
        nameLabel.text = detail.name
        releasedLabel.text = detail.released
        ratingLabel.attributedText = createRatingText(with: detail.rating!)
        
        if let backgroundImageURLString = detail.backgroundImage,
           let backgroundImageURL = URL(string: backgroundImageURLString) {
            gameImageView.kf.setImage(with: backgroundImageURL, placeholder: UIImage(named: "placeholder_image"))
        } else {
            gameImageView.image = UIImage(named: "placeholder_image")
        }
        
        
    }
    
    // MARK: - Private Methods
    
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
}
