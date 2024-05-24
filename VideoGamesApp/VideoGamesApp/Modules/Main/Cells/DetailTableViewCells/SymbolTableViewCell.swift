//
//  SymbolTableViewCell.swift
//  VideoGamesApp
//
//  Created by Ceren Uludoğan on 24.05.2024.
//

import UIKit

class SymbolTableViewCell: UITableViewCell {

    @IBOutlet weak var releasedLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(detailResponse: DetailResponse?) {
        releasedLabel.text = detailResponse?.released
    }
}
