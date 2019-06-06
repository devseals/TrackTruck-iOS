//
//  DetailViewController.swift
//  TrackTruck
//
//  Created by Grecia Sanchez Perez on 6/5/19.
//  Copyright © 2019 pe.edu.upc. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {

    var selectedFoodTruck: Foodtruck?
    var logInVC: LogInVC?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var foodType: UILabel!
    @IBOutlet weak var avgCost: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = selectedFoodTruck?.name
        foodType.text = selectedFoodTruck?.food_type
        avgCost.text = "$ \(selectedFoodTruck!.avg_price)"
        
        mapView.addAnnotation(selectedFoodTruck!)
        centerMap(CLLocation(latitude: selectedFoodTruck!.latitude, longitude: selectedFoodTruck!.longitude))
    }
    
    func centerMap( _ location: CLLocation){
        let coordinateRegion = MKCoordinateRegion(center: selectedFoodTruck!.coordinate, latitudinalMeters: 1000,longitudinalMeters: 1000)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    @IBAction func back(sender: UIButton){
        OperationQueue.main.addOperation {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func reviewsButtonTapped(sender: UIButton){
        performSegue(withIdentifier: "showReviewsVC", sender: self)
    }
    
    @IBAction func addButtonTapped(sender: UIButton){
        performSegue(withIdentifier: "addRevieVC", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showReviewsVC"{
                let destinationViewController = segue.destination as! ReviewsViewController
                destinationViewController.selectedFoodTruck = selectedFoodTruck
        }else if segue.identifier == "addReviewVC"{
            let destinationViewController = segue.destination as! AddReviewViewController
            destinationViewController.selectedFoodTruck = selectedFoodTruck        }
    }
    
}
