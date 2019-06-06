//
//  MainViewController.swift
//  TrackTruck
//
//  Created by Grecia Sanchez Perez on 5/29/19.
//  Copyright © 2019 pe.edu.upc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var dataService = DataService.instance
    var authService = AuthService.instance
    
    var logInVC: LogInVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataService.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        
        DataService.instance.getFoodtrucks()
    }
    
    func showLogInVC(){
       logInVC = LogInVC()
       logInVC?.modalPresentationStyle = UIModalPresentationStyle.formSheet
        self.present(logInVC!,animated: true, completion: nil)
    }
    
    //AQUI TIENES PENDIENTES KENZO
    @IBAction func loginButtonTapped(sender: UIButton){
        if AuthService.instance.isAuthenticated == true {
            performSegue(withIdentifier: "showAddTruckVC", sender: self)
        }else{
            showLogInVC()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailVC"{
            if let indexPath = tableView.indexPathForSelectedRow{
                let destinationViewController = segue.destination as! DetailViewController
                destinationViewController.selectedFoodTruck = DataService.instance.foodtrucks[indexPath.row]
            }
        }
    }

}

extension MainViewController: DataServiceDelegate{
    func trucksLoaded() {
        OperationQueue.main.addOperation {
            self.tableView.reloadData()
        }
    }
    func reviewsLoaded() {
    
    }
    func salesLoaded() {
        
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataService.foodtrucks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FoodtruckCell", for: indexPath) as? FoodtruckCell {
            cell.configureCell(truck: dataService.foodtrucks[indexPath.row])
            return cell
        }else{
            return UITableViewCell()
        }
    }
}
