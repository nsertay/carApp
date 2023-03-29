//
//  CarDetailTwoColumnTextCell.swift
//  carApp
//
//  Created by Nurmukhanbet Sertay on 14.03.2023.
//

import UIKit

class CarDetailTwoColumnTextCell: UITableViewCell {
    
    @IBOutlet var addressLabel: UILabel! 
    
    @IBOutlet var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
