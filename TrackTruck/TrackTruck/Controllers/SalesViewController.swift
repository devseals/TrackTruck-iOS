//
//  SalesViewController.swift
//  TrackTruck
//
//  Created by user917928 on 6/14/19.
//  Copyright © 2019 pe.edu.upc. All rights reserved.
//

import UIKit

class SalesViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 1000
        
        DataService.instance.delegate = self
        
        DataService.instance.getSales()
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

extension SalesViewController: DataServiceDelegate{
    func trucksLoaded() {
        
    }
    
    func reviewsLoaded() {
        
    }
    
    func salesLoaded(){
        OperationQueue.main.addOperation {
            self.tableView.reloadData()
        }
    }
}

extension SalesViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.instance.sales.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SaleCell", for: indexPath) as? SaleCell{
            cell.configureCell(sale: DataService.instance.sales[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
