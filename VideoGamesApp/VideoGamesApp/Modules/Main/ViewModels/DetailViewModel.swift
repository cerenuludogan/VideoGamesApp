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
        case watch
        
    }

    var celltypeList: [DetailTableViewCell] = []
    var detailResponse: DetailResponse?
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
                self.celltypeList.append(.watch)
                self.onDetailFetched?()
                
                
            }
        }
   
    
    var cleanDescription: String {
        return (detailResponse?.description.removingHTMLTags())! 
        }
    
}

extension String {
    func removingHTMLTags() -> String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
