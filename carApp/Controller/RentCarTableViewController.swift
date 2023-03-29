//
//  RentCarTableViewController.swift
//  carApp
//
//  Created by Nurmukhanbet Sertay on 28.03.2023.
//

import UIKit

class RentCarTableViewController: UITableViewController {
    
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var carPrice: UILabel!
    @IBOutlet weak var availableCity: UILabel! {
        didSet {
            availableCity.numberOfLines = 0
        }
    }
    
    @IBOutlet weak var countOfDaysPicker: UIPickerView!
    
    var dateValueMain: String = ""
    var dateOfRent: String?
    
    
    var cars: Car = Car()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        carImage.image = UIImage(data: cars.image)
        brandLabel.text = cars.name
        carPrice.text = cars.type
        availableCity.text = cars.location
        
        
        countOfDaysPicker.dataSource = self
        countOfDaysPicker.delegate = self
        
    }
    
    
    
    
    @IBAction func payment(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "", message: "How do you want to pay?", preferredStyle: .actionSheet)
        let alertActionApplePay = UIAlertAction(title: "Apple Pay", style: .default) { index in
            self.performSegue(withIdentifier: "payment", sender: nil)
        }
        
        let alertActionWithCard = UIAlertAction(title: "With Card", style: .default) { index in
            self.performSegue(withIdentifier: "payment", sender: nil)
        }
        
        let alertActionCancel = UIAlertAction(title: "Cancel", style: .destructive)
        
        alertController.addAction(alertActionApplePay)
        alertController.addAction(alertActionWithCard)
        alertController.addAction(alertActionCancel)
        
        present(alertController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationController = segue.destination as! SuccessPaymentViewController
        
        destinationController.price = "1000"
        destinationController.date = dateValueMain
        
        
    }
    
    
    @IBAction func datePicker(_ sender: UIDatePicker) {
        let dataFormatter = DateFormatter()
        
        dataFormatter.dateStyle = .medium
        
        let dateValue = dataFormatter.string(from: sender.date)
        
        dateValueMain = dateValue
    }
    
    
 
    
    
}

extension RentCarTableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      
        var array: [String] = []
        
        for i in 1...100 {
            
            
            array.append("\(i)")
        }
       
        return array[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(row + 1)
    }
}
