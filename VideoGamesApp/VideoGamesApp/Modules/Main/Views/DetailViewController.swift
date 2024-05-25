//
//  DetailViewController.swift
//  VideoGamesApp
//
//  Created by Ceren Uludoğan on 21.05.2024.
//

import UIKit

import UIKit

class DetailViewController: UIViewController {
    
    var game: GamesResultResponse?
    var viewModel = DetailViewModel()
    @IBOutlet private weak var gameImageView: UIImageView!
    @IBOutlet private weak var shareButton: UIButton!
    @IBOutlet private weak var likeButton: UIButton!
    @IBOutlet private weak var gameratingLabel: UILabel!
    @IBOutlet private weak var gameDateLabel: UILabel!
    @IBOutlet private weak var gameNameLabel: UILabel!
    @IBOutlet private weak var boxLabel: UILabel!
    @IBOutlet private weak var windowsLabel: UILabel!
    @IBOutlet private weak var playstationLabel: UILabel!
    @IBOutlet private weak var detailView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureWindowsLabel()
        configurePlaystationLabel()
        configureBoxLabel()
        configureLikeButton()
        configureShareButton()
       
        if let game = game {
            viewModel.fetchGameDetails(id: game.id!)
            gameNameLabel.text = game.name
            gameDateLabel.text = game.released
            gameratingLabel.attributedText = createRatingText(with: game.rating ?? 0.0)
            if let coinImageURL = GameItemViewModel(game: game).gameImage {
                gameImageView.kf.setImage(with: coinImageURL, placeholder: UIImage(named: "defaultGameImage"))
            } else {
                gameImageView.image = UIImage(named: "defaultGameImage")
            }
        }
        
         viewModel.onDetailFetched = { [weak self] in
            guard let self = self else { return }
            self.updateUI()
        }
    }
    
    private func updateUI() {
        guard let detail = viewModel.detailResponse else { return }
        gameNameLabel.text = detail.name
        gameDateLabel.text = detail.released
        gameratingLabel.text = detail.rating != nil ? "\(detail.rating!)" : "N/A"
        if let imageUrl = detail.backgroundImage, let url = URL(string: imageUrl) {
            gameImageView.load(url: url)
        }
    }

    @IBAction func likeClickedButton(_ sender: UIButton) {
        print("butona tıklandı.")
      //  guard let game else { return }
       // FavoriteManager.shared.favoriteGameList.append(game)
    }

    private func configureView() {
        let cornerRadius: CGFloat = 35
        let corners: UIRectCorner = [.topLeft, .topRight]
        let path = UIBezierPath(roundedRect: detailView.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        detailView.layer.mask = mask
      
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = detailView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0.1
        detailView.addSubview(blurEffectView)
    }

    private func configurePlaystationLabel() {
        guard game != nil else { return }
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
        guard game != nil else { return }
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
        guard game != nil else { return }
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

    private func configureShareButton() {
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "square.and.arrow.up")
        configuration.title = "Share"
        configuration.baseForegroundColor = .white
        configuration.imagePadding = 8.0
        configuration.imagePlacement = .leading

        let customColor = UIColor(hex: "#775386")
        shareButton.layer.cornerRadius = 15
        shareButton.backgroundColor = customColor
        shareButton.configuration = configuration
        shareButton.configuration = configuration
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
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
