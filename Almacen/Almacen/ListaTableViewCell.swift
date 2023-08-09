//
//  ListaTableViewCell.swift
//  Almacen
//
//  Created by beyser on 30/07/23.
//  Copyright © 2023 beyser. All rights reserved.
//

import UIKit

class ListaTableViewCell: UITableViewCell {

    
    @IBOutlet weak var skuLabel: UILabel!
    @IBOutlet weak var nombreLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var fechaLabel: UILabel!
    @IBOutlet weak var motivoLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
