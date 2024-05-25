//
//  WatchButtonTableViewCell.swift
//  VideoGamesApp
//
//  Created by Ceren Uludoğan on 25.05.2024.
//

import UIKit

class WatchButtonTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet private weak var watchButton: UIButton!
    
    // MARK: - Lifecycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureShareButton()
    }
    
    // MARK: - Helper Methods
    
    @IBAction func watchCliked(_ sender: UIButton) {
        showAlert()
    }
    private func configureShareButton() {
        var configuration = UIButton.Configuration.plain()
        configuration.title = "Watch"
        configuration.baseForegroundColor = .white
        configuration.imagePadding = 8.0
        configuration.imagePlacement = .leading

        let customColor = UIColor(hex: "#775386")
        watchButton.layer.cornerRadius = 25
        watchButton.backgroundColor = customColor
        watchButton.configuration = configuration
        watchButton.configuration = configuration
    }
    private func showAlert() {
            let alert = UIAlertController(title: "Sorry", message: "Currently, it cannot be watched.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        }
}
