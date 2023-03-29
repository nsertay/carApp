//
//  CarTableViewController.swift
//  carApp
//
//  Created by Nurmukhanbet Sertay on 10.03.2023.
//

import UIKit
import CoreData

class CarTableViewController: UITableViewController {
    
    var cars: [Car] = []
    
    var favoriteArray = Array(repeating: false, count: 4)
    
    let color = UIColor(named: "NavigationBarTitle")!
    
    lazy var dataSource = configureDataSource()
    
    @IBOutlet var carEmptyView: UIView!
    
    var fetchResultController: NSFetchedResultsController<Car>!
    
    var searchController: UISearchController!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        tableView.cellLayoutMarginsFollowReadableWidth = true
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Car>()
        snapshot.appendSections([.all])
        snapshot.appendItems(cars, toSection: .all)
        
        dataSource.apply(snapshot, animatingDifferences: false)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.separatorStyle = .none
        
        navigationController?.hidesBarsOnSwipe = true
        
        
        
        if let appearance = navigationController?.navigationBar.standardAppearance {
            appearance.configureWithTransparentBackground()
            
            if let customFont = UIFont(name: "Nunito-Bold", size: 45.0) {
                appearance.titleTextAttributes = [.foregroundColor: color]
                appearance.largeTitleTextAttributes = [.foregroundColor: color, .font: customFont]
            }
            
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            
            tableView.tableFooterView = UIView(frame: .zero)
                
        }
        
        
        tableView.backgroundView = carEmptyView
        tableView.backgroundView?.isHidden = cars.count == 0 ? false : true
        
        fetchRestaurantData()
        
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        
    }
    
    
    
    func configureDataSource() -> CarDiffableDataSource {
        
        let cellIdentier = "carcell"
        
        let dataSource = CarDiffableDataSource (
            tableView: tableView,
            cellProvider: { tableView, indexPath, car in
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentier, for: indexPath) as! CarTableViewCell
                cell.carImage.image = UIImage(data: car.image)
                cell.brandLabel.text = car.name
                cell.carPrice.text = car.type
                cell.availableCity.text = car.location
                cell.favoriteImageView.isHidden = car.isFavorite ? false : true
                cell.selectionStyle = .none
                
                return cell
        }
        )
        return dataSource
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        guard let car = self.dataSource.itemIdentifier(for: indexPath)
        else {
            
            return UISwipeActionsConfiguration()
        }

        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, sourceView, completionHandler in
            
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                let context = appDelegate.persistentContainer.viewContext
                
                context.delete(car)
                appDelegate.saveContext()
                
                self.updateSnapshot(animatingChange: true)
            }
       
            completionHandler(true)
        }
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        
        
        return swipeConfiguration
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cardetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! CarDetailReservateViewController
                
                destinationController.cars = self.cars[indexPath.row]
                destinationController.hidesBottomBarWhenPushed = true
                
            }
        }
    }
    
    @IBAction func closeAddWindow(segue: UIStoryboardSegue) {
        dismiss(animated: true)
    }
    
    func updateSnapshot(animatingChange: Bool = false) {
        if let fetchedObjects = fetchResultController.fetchedObjects {
            cars = fetchedObjects
        }
        // Create a snapshot and populate the data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Car>()
        snapshot.appendSections([.all])
        snapshot.appendItems(cars, toSection: .all)
        dataSource.apply(snapshot, animatingDifferences: animatingChange)
        
        tableView.backgroundView?.isHidden = cars.count == 0 ? false : true
    }
    
    
    func fetchRestaurantData(searchText: String = "") {
        
        let fetchRequest: NSFetchRequest<Car> = Car.fetchRequest()
        
        if !searchText.isEmpty {
            fetchRequest.predicate = NSPredicate(format: "name CONTAINS[c] %@ OR location CONTAINS[c] %@", searchText, searchText)
        }
    
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            do {
                try fetchResultController.performFetch()
                updateSnapshot()
            } catch {
                print(error)
            }
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        if let walkthroughViewController = storyboard.instantiateViewController(withIdentifier: "WalkthroughViewController") as? WalkthroughViewController {
            present(walkthroughViewController, animated: true, completion: nil)
        }
    }
}

extension CarTableViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        updateSnapshot()
    }
}

extension CarTableViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchText = searchController.searchBar.text else {
            return
        }
        
        fetchRestaurantData(searchText: searchText)
    }
}
