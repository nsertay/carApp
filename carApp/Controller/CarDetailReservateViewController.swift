//
//  CarDetailReservateViewController.swift
//  carApp
//
//  Created by Nurmukhanbet Sertay on 13.03.2023.
//

import UIKit


class CarDetailReservateViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var headerView: CarDetailHeaderView!
    

    
    var cars: Car = Car()
    
    
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headerView.headerImageView.image = UIImage(data: cars.image)
        headerView.priceLabel.text = cars.type
        headerView.brandLabel.text = cars.name
        
        let heartImage = cars.isFavorite ? "heart.fill" : "heart"
        headerView.heartButton.tintColor = cars.isFavorite ? .systemYellow : .black
        headerView.heartButton.setImage(UIImage(systemName: heartImage), for: .normal)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.hidesBarsOnSwipe = true
       
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.dataSource = self
        tableView.delegate = self
        
       
        
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showMap":
            let destinationController = segue.destination as! MapViewController
            destinationController.car = cars
        case "rentcar":
            let destinationController = segue.destination as! RentCarTableViewController
            destinationController.cars = cars
        default: break
    } }
    
}


extension CarDetailReservateViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let firstIdentifier = "detail"
        let secondIdentifier = "twocolumn"
        let thirdIdentifier = "mapcell"
        
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: firstIdentifier, for: indexPath) as! CarDetailTextCell
            
            cell.detailLabel.text = cars.summary
            cell.selectionStyle = .none
            
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: secondIdentifier, for: indexPath) as! CarDetailTwoColumnTextCell
            
            cell.addressLabel.text = cars.location
            cell.priceLabel.text = cars.type
            cell.selectionStyle = .none
            
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: thirdIdentifier, for: indexPath) as!
            CarDetailMapCell
            
            cell.configure(location: cars.location)
            cell.selectionStyle = .none
            
            return cell
            
            
        default:
            fatalError("Failed to instantiate the table view cell for deta il view controller")
        }
    }
    
    @IBAction func close(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
}
    
