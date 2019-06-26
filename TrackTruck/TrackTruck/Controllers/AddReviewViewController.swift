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
    
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var contentText: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    
    @IBAction func addButtonTapped(sender: UIButton){
        guard   let title = titleLabel.text, titleLabel.text != "",
                let content = contentText.text, contentText.text != "",
            let truck = selectedFoodTruck else{
                self.showAlert(with: "ERROR", message: "COMPLETA LOS CAMPOS")
                return
        }
        DataService.instance.createReview(
            foodTruckId: selectedFoodTruck!.id,
            content: content,
            title: title,
            userId: AuthService.instance.userId!,
            completion: {
            Success in
            if Success{
                print("Saved REVIEW")
                DataService.instance.getReviews(for: truck)
                OperationQueue.main.addOperation {
                    _ = self.navigationController?.popViewController(animated: true)
                }
                self.showAlert(with: "Exito", message: "Se registro la reseña de forma exitosa")
            }else{
                self.showAlert(with: "Error:", message: "Algo salio mal")
            }
        })
    }
    
    func showAlert(with title: String?, message: String?){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default , handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    @IBAction func back(sender: UIButton){
        OperationQueue.main.addOperation {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func cancelButtonTapped(sender: UIButton){
        OperationQueue.main.addOperation {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
