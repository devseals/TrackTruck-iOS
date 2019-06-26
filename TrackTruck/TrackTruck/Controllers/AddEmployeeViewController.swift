//
//  AddEmployeeViewController.swift
//  TrackTruck
//
//  Created by Erikson Daniel Pérez Márquez on 6/17/19.
//  Copyright © 2019 pe.edu.upc. All rights reserved.
//

import UIKit

class AddEmployeeViewController: UIViewController {

    @IBOutlet weak var nombreTextField: UITextField!
    @IBOutlet weak var usuarioTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func AgregarButtonTapped(_ sender: UIButton) {
        guard   let name = nombreTextField.text, nombreTextField.text != "",
            let username = usuarioTextField.text, usuarioTextField.text != "",
            let password = passwordTextField.text, passwordTextField.text != "" else{
                self.showAlert(with: "ERROR", message: "COMPLETA LOS CAMPOS")
                return
        }
        AuthService.instance.registerEmployee(
            username: username,
            password: password,
            name: name,
            owner_id: AuthService.instance.ownerId!,
            completion: {
                Success in
                if Success{
                    print("Saved Employee")
                    OperationQueue.main.addOperation {
                        _ = self.navigationController?.popViewController(animated: true)
                    }
                    self.showAlert(with: "Exito", message: "Se registro el vendedor de forma exitosa")
                }else{
                    self.showAlert(with: "Error:", message: "Algo salio mal")
                }
        })
    }
    
    @IBAction func CancelarButtonTapped(_ sender: UIButton) {
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
