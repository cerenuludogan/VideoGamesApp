//
//  TextTableViewCell.swift
//  VideoGamesApp
//
//  Created by Ceren Uludoğan on 24.05.2024.
//

import UIKit

class TextTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet private weak var descriptionTextView: UITextView!
   
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

  
    
    // MARK: - Public Methods
    func setupCell(detailViewModel: DetailViewModel?) {
        descriptionTextView.text = detailViewModel?.cleanDescription
        
    }
   
}
