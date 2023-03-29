//
//  CarDiffableDataSource.swift
//  carApp
//
//  Created by Nurmukhanbet Sertay on 13.03.2023.
//

import UIKit

enum Section {
    case all
}
class CarDiffableDataSource: UITableViewDiffableDataSource<Section, Car> {
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            if let restaurant = self.itemIdentifier(for: indexPath) {
                var snapshot = snapshot()
                snapshot.deleteItems([restaurant])
                
                self.apply(snapshot, animatingDifferences: true)
            }
        }
    }

}
