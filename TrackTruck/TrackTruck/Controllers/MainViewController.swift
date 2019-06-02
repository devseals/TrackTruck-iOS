//
//  MainViewController.swift
//  TrackTruck
//
//  Created by Grecia Sanchez Perez on 5/29/19.
//  Copyright © 2019 pe.edu.upc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        DataService.instance.delegate = self
        DataService.instance.getFoodtrucks()
    }

}

extension MainViewController: DataServiceDelegate{
    func trucksLoaded() {
        print(DataService.instance.foodtrucks)
    }
    func reviewsLoaded() {
    
    }
    func salesLoaded() {
        
    }
}
