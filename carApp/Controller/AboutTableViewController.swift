//
//  AboutTableViewController.swift
//  carApp
//
//  Created by Nurmukhanbet Sertay on 28.03.2023.
//

import UIKit
import SafariServices

class AboutTableViewController: UITableViewController {
    
    lazy var dataSource = configureDataSource()
    
    enum Section {
        case feedback
        case followus
    }
    
    struct LinkItem: Hashable {
        var text: String
        var link: String
        var image: String
    }

    var sectionContent = [
        [LinkItem(text: "Rate us on App Store", link: "https://www.apple.com/ios/app-store/", image: "store"),
         LinkItem(text: "Tell us your feedback", link: "http://www.appcoda.com/contact", image: "chat")],
        [LinkItem(text: "Kolesa", link: "https://kolesa.kz/a/show/150594149", image: "chat"),
         LinkItem(text: "Facebook", link: "https://facebook.com/appcodamobile", image: "facebook"),
         LinkItem(text: "Instagram", link: "https://www.instagram.com/appcodadotcom", image: "instagram")]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        if let appearnce = navigationController?.navigationBar.standardAppearance {
            
            appearnce.configureWithTransparentBackground()
            
            if let customFont = UIFont(name: "Nunito-Bold", size: 45.0) {
                
                appearnce.titleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle")!]
                appearnce.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle")!, .font: customFont]
            }
            
            navigationController?.navigationBar.standardAppearance = appearnce
            navigationController?.navigationBar.compactAppearance = appearnce
            navigationController?.navigationBar.scrollEdgeAppearance = appearnce
        }

        
        tableView.dataSource = dataSource
        
        updateSnapshot()
    }
  
    func configureDataSource() -> UITableViewDiffableDataSource<Section, LinkItem> {
        
        let cellIdentifier = "aboutcell"
        
        let dataSource = UITableViewDiffableDataSource<Section, LinkItem> (tableView: tableView) { (tableView, indexPath, linkItem) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
            cell?.textLabel?.text = linkItem.text
            cell?.imageView?.image = UIImage(named: linkItem.image)
            
            return cell
            
        }
        
        return dataSource
        
    }
    
    func updateSnapshot() {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, LinkItem>()
        snapshot.appendSections([.feedback, .followus])
        snapshot.appendItems(sectionContent[0], toSection: .feedback)
        snapshot.appendItems(sectionContent[1], toSection: .followus)
        
        dataSource.apply(snapshot)
        
    }
    
    func openWithSafariViewController(indexPath: IndexPath) {
        guard let linkItem = self.dataSource.itemIdentifier(for: indexPath) else { return }
        
        if let url = URL(string: linkItem.link) {
            let SFController = SFSafariViewController(url: url)
            present(SFController, animated: true)
        }
            
            
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openWithSafariViewController(indexPath: indexPath)
    }
}
