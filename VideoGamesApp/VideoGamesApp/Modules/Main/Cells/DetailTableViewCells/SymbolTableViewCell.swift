//
//  SymbolTableViewCell.swift
//  VideoGamesApp
//
//  Created by Ceren Uludoğan on 24.05.2024.
//

import UIKit

class SymbolTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var boxLabel: UILabel!
    @IBOutlet private weak var playstationLabel: UILabel!
    @IBOutlet private weak var windowsLabel: UILabel!
    @IBOutlet private weak var releasedLabel: UILabel!
    @IBOutlet private weak var symbolView: UIView!
    
    var game: GamesResultResponse?
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configurePlaystationLabel()
           configureBoxLabel()
           configureWindowsLabel()
    }
   
    // MARK: - Private Methods
    private func configurePlaystationLabel() {
        let attachment = NSTextAttachment()
        if let windowImage = UIImage(systemName: "playstation.logo")?.withTintColor(.white, renderingMode: .alwaysOriginal) {
            attachment.image = windowImage
        }
        attachment.bounds = CGRect(x: 0, y: -5, width: 30, height: 30)
        let attachmentString = NSAttributedString(attachment: attachment)
        let completeString = NSMutableAttributedString()
        completeString.append(attachmentString)
        playstationLabel.attributedText = completeString
    }
    private func configureBoxLabel() {
        let attachment = NSTextAttachment()
        if let windowImage = UIImage(systemName: "xbox.logo")?.withTintColor(.white, renderingMode: .alwaysOriginal) {
            attachment.image = windowImage
        }
        attachment.bounds = CGRect(x: 0, y: -5, width: 30, height: 30)
        let attachmentString = NSAttributedString(attachment: attachment)
        let completeString = NSMutableAttributedString()
        completeString.append(attachmentString)
        boxLabel.attributedText = completeString
    }
    private func configureWindowsLabel() {
        let attachment = NSTextAttachment()
        if let windowImage = UIImage(systemName: "window.horizontal.closed")?.withTintColor(.white, renderingMode: .alwaysOriginal) {
            attachment.image = windowImage
        }
        attachment.bounds = CGRect(x: 0, y: -5, width: 30, height: 30)
        let attachmentString = NSAttributedString(attachment: attachment)
        let completeString = NSMutableAttributedString()
        completeString.append(attachmentString)
        windowsLabel.attributedText = completeString
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
    
    func setupCell(detailResponse: DetailResponse?) {
        releasedLabel.text = detailResponse?.released
        ratingLabel.attributedText = createRatingText( with: (detailResponse?.rating!)!)
        configurePlaystationLabel()
        configureBoxLabel()
        configureWindowsLabel()
    }
}
