//
//  SaleCell.swift
//  TrackTruck
//
//  Created by user917928 on 6/14/19.
//  Copyright © 2019 pe.edu.upc. All rights reserved.
//

import UIKit

class SaleCell: UITableViewCell {

    @IBOutlet weak var registerLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(sale: Sale){
        registerLabel.text = sale.employeeName
        dateLabel.text = sale.date
        contentLabel.text = sale.content
        amountLabel.text = "$\(sale.value)"
    }

}




































