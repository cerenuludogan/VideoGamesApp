//
//  ImageTableViewCell.swift
//  VideoGamesApp
//
//  Created by Ceren Uludoğan on 24.05.2024.
//

import UIKit
import Kingfisher
class ImageTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var gameImageView: UIImageView!
    @IBOutlet private weak var nameView: UIView!
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    // MARK: - Public Methods
    func setupCell(detail: DetailResponse) {
        nameLabel.text = detail.name
           if let backgroundImageURLString = detail.backgroundImage,
              let backgroundImageURL = URL(string: backgroundImageURLString) {
               gameImageView.kf.setImage(with: backgroundImageURL, placeholder: UIImage(named: "placeholder_image"))
           } else {
               gameImageView.image = UIImage(named: "placeholder_image")
           }
    }

}
