//
//  CustomCell.swift
//  Domicilios
//
//  Created by Carlos Buitrago on 8/09/16.
//  Copyright © 2016 Carlos Buitrago. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet var foto: UIImageView!
    @IBOutlet var nombre: UILabel!
    @IBOutlet var categoria: UILabel!
    @IBOutlet weak var e1: UIImageView!
    @IBOutlet weak var e2: UIImageView!
    @IBOutlet weak var e3: UIImageView!
    @IBOutlet weak var e4: UIImageView!
    @IBOutlet weak var e5: UIImageView!
    @IBOutlet weak var precio: UILabel!
    @IBOutlet weak var minutos: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
