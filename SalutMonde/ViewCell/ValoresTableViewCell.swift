//
//  ActividadTableViewCell.swift
//  SalutMonde
//
//  Created by Ariana Esquivel on 15/04/21.
//

import UIKit

class ValoresTableViewCell: UITableViewCell {

    @IBOutlet weak var lblFecha: UILabel!
    @IBOutlet weak var lblTemperatura: UILabel!
    @IBOutlet weak var lblHumedad: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
