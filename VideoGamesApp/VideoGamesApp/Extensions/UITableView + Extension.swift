//
//  UITableView.swift
//  VideoGamesApp
//
//  Created by Ceren Uludoğan on 19.05.2024.
//
import UIKit

extension UITableView {
    
    func register(cellType: UITableViewCell.Type) {
        register(cellType.nib, forCellReuseIdentifier: cellType.identifier)
    }
    
    func dequeCell<T: UITableViewCell>(cellType: T.Type, indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath) as? T else { fatalError("error") }
        return cell
    }
}

