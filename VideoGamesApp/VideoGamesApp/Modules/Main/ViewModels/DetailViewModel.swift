//
//  DetailViewModel.swift
//  VideoGamesApp
//
//  Created by Ceren Uludoğan on 24.05.2024.
//

import Foundation

final class DetailViewModel {
    
    enum DetailTableViewCell {
        case headerImage
        case info
        case action
        case description
    }
    
    
    var detailResponse: DetailResponse?
    var celltypeList: [DetailTableViewCell] = []
    var gameDetailList: [DetailResponse] = []
    
    var onDetailFetched: (() -> Void)?

    func fetchGameDetails(id: Int) {
            ServiceManager.shared.fetchGameDetails(id: id) { [weak self] detailResponse in
                guard let self = self else { return }
                self.detailResponse = detailResponse
                self.celltypeList.append(.headerImage)
                self.celltypeList.append(.info)
                self.celltypeList.append(.action)
                self.celltypeList.append(.description)
                self.onDetailFetched?()
            }
        }
    
}
