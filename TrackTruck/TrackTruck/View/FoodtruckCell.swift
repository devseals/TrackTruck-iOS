//
//  FoodtruckCell.swift
//  TrackTruck
//
//  Created by Grecia Sanchez Perez on 6/3/19.
//  Copyright © 2019 pe.edu.upc. All rights reserved.
//

import UIKit

class FoodtruckCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var foodType: UILabel!
    @IBOutlet weak var avgPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(truck: Foodtruck){
        nameLabel.text = truck.name
        foodType.text = truck.food_type
        avgPrice.text = "$\(truck.avg_price)"
    }
    
}
