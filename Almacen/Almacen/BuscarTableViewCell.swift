//
//  BuscarTableViewCell.swift
//  Almacen
//
//  Created by beyser on 30/06/23.
//  Copyright © 2023 beyser. All rights reserved.
//

import UIKit

class BuscarTableViewCell: UITableViewCell {

    @IBOutlet weak var imgImageView: UIImageView!
    @IBOutlet weak var proveedorLabel: UILabel!
    @IBOutlet weak var nombreLabel: UILabel!
    @IBOutlet weak var skuLabel: UILabel!
    @IBOutlet weak var precioLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

   

}
