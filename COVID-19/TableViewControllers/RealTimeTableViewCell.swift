//
//  RealTimeTableViewCell.swift
//  COVID-19
//
//  Created by Rodrigo Matos on 26/02/2021.
//

import UIKit

class RealTimeTableViewCell: UITableViewCell {


    @IBOutlet weak var confirmed: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var capital: UILabel!
    @IBOutlet weak var deaths: UILabel!
    @IBOutlet weak var recovered: UILabel!
    @IBOutlet weak var population: UILabel!
    @IBOutlet weak var lifeEx: UILabel!
    @IBOutlet weak var latLong: UILabel!
    @IBOutlet weak var continent: UILabel!
    @IBOutlet weak var update: UILabel!
    
    @IBOutlet weak var teste: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        teste.layer.cornerRadius = 5
        teste.layer.shadowColor = UIColor.gray.cgColor
        teste.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        teste.layer.shadowRadius = 10.0
        teste.layer.shadowOpacity = 0.5
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
    


}
