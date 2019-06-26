//
//  AddSaleViewController.swift
//  TrackTruck
//
//  Created by user917928 on 6/12/19.
//  Copyright © 2019 pe.edu.upc. All rights reserved.
//

import UIKit

class AddSaleViewController: UIViewController {
    
    @IBOutlet weak var detailText: UITextField!
    @IBOutlet weak var valueText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addButtonTapped(sender: UIButton) {
        guard   let detail = detailText.text, detailText.text != "",
            let value = valueText.text, valueText.text != ""
            else {
                self.showAlert(with: "ERROR", message: "COMPLETA LOS CAMPOS")
                return
        }
        
        let valueNumber = Double(value)!
        
        DataService.instance.createSale(
            employee_id: AuthService.instance.employeeId!,
            value: valueNumber,
            content: detail,
            completion: {
                Success in
                if Success {
                    print("Saved Sale")
                   
                } else {
                    self.showAlert(with: "Error: ", message: "Algo salio mal")
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
