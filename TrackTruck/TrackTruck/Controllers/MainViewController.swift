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
    @IBOutlet weak var addButton: UIImageView!
    
    var dataService = DataService.instance
    var authService = AuthService.instance
    
    var logInVC: LogInVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataService.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        DataService.instance.getFoodtrucks()
    }
    
    func showLogInVC(){
        logInVC = LogInVC()
        logInVC?.modalPresentationStyle = UIModalPresentationStyle.formSheet
        self.present(logInVC!,animated: true, completion: nil)
    }
    
    @IBAction func loginButtonTapped(sender: UIButton){
        if AuthService.instance.isAuthenticated == true {
            performSegue(withIdentifier: "", sender: self)
        }else{
            showLogInVC()
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FoodtruckCell", for: indexPath) as? FoodtruckCell{
            cell.configureCell(truck: dataService.foodtrucks[indexPath.row])
            return cell
        }else{
            return UITableViewCell()
        }
    }
}
