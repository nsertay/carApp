//
//  CarDetailHeaderView.swift
//  carApp
//
//  Created by Nurmukhanbet Sertay on 14.03.2023.
//

import UIKit

class CarDetailHeaderView: UIView {

    @IBOutlet var headerImageView: UIImageView!
    @IBOutlet var ratingImageView: UIImageView!
  
    @IBOutlet var brandLabel: UILabel! {
        
        didSet {
            brandLabel.numberOfLines = 1
            
            if let customFont = UIFont(name: "Nunito-Bold", size: 26.0) {
                brandLabel.font = UIFontMetrics(forTextStyle: .title1).scaledFont(for: customFont)
            }
        }
    }
    
    @IBOutlet var priceLabel: UILabel! {
        didSet {
            if let customFont = UIFont(name: "Nunito-Bold", size: 13.0) {
                priceLabel.font = UIFontMetrics(forTextStyle: .subheadline).scaledFont(for: customFont)
            }
        }
        
    }
    @IBOutlet var heartButton: UIButton!

}
