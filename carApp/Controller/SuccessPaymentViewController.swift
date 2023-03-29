//
//  SuccessPaymentViewController.swift
//  carApp
//
//  Created by Nurmukhanbet Sertay on 28.03.2023.
//

import UIKit

class SuccessPaymentViewController: UIViewController {

    @IBOutlet weak var dateRateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var date: String = ""
    var price: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        dateRateLabel.text = date
        priceLabel.text = "\(price) $"

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
