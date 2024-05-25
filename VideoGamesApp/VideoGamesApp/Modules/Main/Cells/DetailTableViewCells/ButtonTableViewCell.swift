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
    var detail: DetailResponse?
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLikeButton()
        configureShareButton()
    }
    func addToFavoritesButtonTapped() {
        // Favori olarak işaretlenen oyunun detaylarına erişim sağlayın
        if let selectedGameDetail = self.detail {
            // Favori oyunları listesine ekleyin
            FavoriteManager.shared.addFavoriteGame(selectedGameDetail)
        }
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
    private func showShareNotAllowedAlert() {
        let alert = UIAlertController(title: "Sorry", message: "Sharing is not allowed at the moment.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func LikeButtonClicked(_ sender: UIButton) {
        likeButtonAction?()
        if let selectedGameDetail = self.detail {
                FavoriteManager.shared.addFavoriteGame(selectedGameDetail)
            }
               
    }
  
    @IBAction func shareButtonClicked(_ sender: UIButton) {
        showShareNotAllowedAlert()
    }
}

