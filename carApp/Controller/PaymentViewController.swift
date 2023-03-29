//
//  PaymentViewController.swift
//  carApp
//
//  Created by Nurmukhanbet Sertay on 28.03.2023.
//

import UIKit

class PaymentViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var cars: Car = Car()
 
   
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
   

}

extension PaymentViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "rentcarcell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CarTableViewCell
        
        cell.availableCity.text = cars.location
        cell.carImage.image = UIImage(data: cars.image)
        cell.carPrice.text = cars.type
        cell.brandLabel.text = cars.name
        
        return cell
    }
}
