//
//  BorderButton.swift
//  carApp
//
//  Created by Nurmukhanbet Sertay on 04.03.2023.
//

import UIKit

class BorderButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 3.0
        layer.borderColor = UIColor.white.cgColor
    }
    
}
