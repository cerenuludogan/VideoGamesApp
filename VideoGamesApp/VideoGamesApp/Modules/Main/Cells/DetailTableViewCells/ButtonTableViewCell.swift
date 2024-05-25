//
//  ButtonTableViewCell.swift
//  VideoGamesApp
//
//  Created by Ceren Uludoğan on 24.05.2024.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {
        
    // MARK: - Outlets
    @IBOutlet private weak var sharedButton: UIButton!
    @IBOutlet private weak var likeButton: UIButton!
    var likeButtonAction: (() -> Void)?
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLikeButton()
        configureShareButton()
    }
    
    // MARK: - Private Methods
    private func configureShareButton() {
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "square.and.arrow.up")
        configuration.title = "Share"
        configuration.baseForegroundColor = .white
        configuration.imagePadding = 8.0
        configuration.imagePlacement = .leading

        let customColor = UIColor(hex: "#775386")
        sharedButton.layer.cornerRadius = 15
        sharedButton.backgroundColor = customColor
        sharedButton.configuration = configuration
        sharedButton.configuration = configuration
    }
    private func configureLikeButton() {
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "heart.fill")
        configuration.title = "Like"
        configuration.baseForegroundColor = .white
        configuration.imagePadding = 8.0
        configuration.imagePlacement = .leading

        let customColor = UIColor(hex: "#775386")
        likeButton.layer.cornerRadius = 15
        likeButton.backgroundColor = customColor
        likeButton.configuration = configuration
    }
    
    
    @IBAction func LikeButtonClicked(_ sender: UIButton) {
        likeButtonAction?()
               
    }
  
}

