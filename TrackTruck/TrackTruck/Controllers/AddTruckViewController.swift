//
//  AddTruckViewController.swift
//  TrackTruck
//
//  Created by Grecia Sanchez Perez on 6/5/19.
//  Copyright © 2019 pe.edu.upc. All rights reserved.
//

import UIKit

class AddTruckViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var avg_costFieldField: UITextField!
    @IBOutlet weak var food_typeField: UITextField!
    @IBOutlet weak var latitudeField: UITextField!
    @IBOutlet weak var longitudeField: UITextField!
    @IBOutlet weak var phoneField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func back(sender: UIButton){
        OperationQueue.main.addOperation {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func addButton(sender: UIButton){
        guard   let name = nameField.text, nameField.text != "",
                let cost = Double(avg_costFieldField.text!), avg_costFieldField.text != "",
                let type = food_typeField.text, food_typeField.text != "",
                let lat = Double(latitudeField.text!), latitudeField.text != "",
                let lon = Double(longitudeField.text!), longitudeField.text != "",
                let phone = phoneField.text, phoneField.text != "" else{
            self.showAlert(with: "Error", message: "Complete los campos")
            return
        }
        
        //AQUI FALTA VER COMO JALAR EL OWNER ID
        
        DataService.instance.createFoodtruck(
            name: name,
            food_type: type,
            avg_price: cost,
            latitude: lat,
            longitude: lon,
            phone: phone,
            owner_id: AuthService.instance.ownerId!,
            completion: {
                Success in
                
                if Success{
                    print("FT GUARDADO")
                    DataService.instance.getFoodtrucks()
                    OperationQueue.main.addOperation {
                        _ = self.navigationController?.popViewController(animated: true)
                    }
                    self.showAlert(with: "Exito", message: "Se registro el foodtruck de forma exitosa")
                }else{
                    self.showAlert(with: "Error:", message: "Algo salio mal")
                }
        })
    }
    
    @IBAction func cancelButtonTapped(sender: UIButton){
        OperationQueue.main.addOperation {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    func showAlert(with title: String?, message: String?){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default , handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
