//
//  AddReviewViewController.swift
//  TrackTruck
//
//  Created by Grecia Sanchez Perez on 6/5/19.
//  Copyright © 2019 pe.edu.upc. All rights reserved.
//

import UIKit

class AddReviewViewController: UIViewController {

    var selectedFoodTruck: Foodtruck?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }

    @IBAction func back(sender: UIButton){
        OperationQueue.main.addOperation {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
}
