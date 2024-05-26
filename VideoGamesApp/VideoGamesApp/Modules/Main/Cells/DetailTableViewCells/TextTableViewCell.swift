//
//  TextTableViewCell.swift
//  VideoGamesApp
//
//  Created by Ceren Uludoğan on 24.05.2024.
//

import UIKit

class TextTableViewCell: UITableViewCell {
    
    private var gameDescription: String = ""

    // MARK: - Outlets
    @IBOutlet private weak var descriptionTextView: UILabel!
   
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Public Methods
    func setupCell(detailViewModel: DetailViewModel?) {
        descriptionTextView.text = detailViewModel?.cleanDescription ?? ""
    }
   
}
