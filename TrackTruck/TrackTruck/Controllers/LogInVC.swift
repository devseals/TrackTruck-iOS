//
//  LogInVC.swift
//  TrackTruck
//
//  Created by Grecia Sanchez Perez on 6/3/19.
//  Copyright © 2019 pe.edu.upc. All rights reserved.
//

import UIKit

class LogInVC: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var usernameTextField2: UITextField!
    @IBOutlet weak var passwordTextField2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func cancelButtonTapped(sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registerButtonTapped(sender: UIButton){
        guard let name = nameTextField.text, nameTextField.text != "",
              let pass = passwordTextField.text, passwordTextField.text != "",
              let user = usernameTextField.text, usernameTextField.text != "",
              let phone = phoneTextField.text, phoneTextField.text != "" else{
                self.showAlert(with: "Error", message: "Complete los campos")
                return
        }
        AuthService.instance.registerUser(username: user, password: pass, name: name, phone: phone, completion: {Success in
            if Success {
                AuthService.instance.logInUser(username: user, password: pass, completion: {Success in
                    if Success{
                        self.dismiss(animated: true, completion: nil)
                    }else{
                        OperationQueue.main.addOperation {
                            self.showAlert(with: "Error", message: "Contrasena Incorrecta")
                        }
                    }
                })
            }else{
                OperationQueue.main.addOperation {
                    self.showAlert(with: "Error", message: "Algo salio mal en el registro.")
                }
            }
        })
    }
    
    @IBAction func loginButtonTapped(sender: UIButton){
        guard let pass = passwordTextField2.text, passwordTextField2.text != "",
            let user = usernameTextField2.text, usernameTextField2.text != "" else{
                self.showAlert(with: "Error", message: "Complete los campos")
                return
        }
        
        AuthService.instance.logInUser(username: user, password: pass, completion: {Success in
                    if Success{
                        self.dismiss(animated: true, completion: nil)
                    }else{
                        OperationQueue.main.addOperation {
                            self.showAlert(with: "Error", message: "Contrasena Incorrecta")
                        }
                    }
                })

    }
    
    func showAlert(with title: String?, message: String?){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
