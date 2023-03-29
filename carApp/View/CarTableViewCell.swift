//
//  CarTableViewCell.swift
//  carApp
//
//  Created by Nurmukhanbet Sertay on 11.03.2023.
//

import UIKit

class CarTableViewCell: UITableViewCell {

    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var carPrice: UILabel!
    @IBOutlet weak var availableCity: UILabel! {
        didSet {
            availableCity.numberOfLines = 0
        }
    }
    @IBOutlet weak var favoriteImageView: UIImageView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
