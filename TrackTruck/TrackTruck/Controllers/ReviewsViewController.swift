//
//  ReviewsViewController.swift
//  TrackTruck
//
//  Created by Grecia Sanchez Perez on 6/5/19.
//  Copyright © 2019 pe.edu.upc. All rights reserved.
//

import UIKit

class ReviewsViewController: UIViewController {

    var selectedFoodTruck: Foodtruck?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 1000
        
        DataService.instance.delegate = self
        
        if let truck = selectedFoodTruck{
            DataService.instance.getReviews(for: truck)
        }
        
    }
    
    @IBAction func back(sender: UIButton){
        OperationQueue.main.addOperation {
            _ = self.navigationController?.popViewController(animated: true)
        }
        OperationQueue.main.addOperation {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }

    
}

extension ReviewsViewController: DataServiceDelegate{
    func salesLoaded() {
    
    }
    func trucksLoaded(){
        
    }
    func reviewsLoaded(){
        OperationQueue.main.addOperation {
            self.tableView.reloadData()
        }
    }
}

extension ReviewsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.instance.reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as? ReviewCell{
            cell.configureCell(review: DataService.instance.reviews[indexPath.row])
            return cell
        }else{
            return UITableViewCell()
        }
    }
}
