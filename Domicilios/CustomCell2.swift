//
//  CustomCell2.swift
//  Domicilios
//
//  Created by Carlos Buitrago on 10/09/16.
//  Copyright © 2016 Carlos Buitrago. All rights reserved.
//

import UIKit

class CustomCell2: UITableViewCell {

    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var foto: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
