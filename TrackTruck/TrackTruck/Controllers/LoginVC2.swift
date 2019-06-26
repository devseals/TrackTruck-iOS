//
//  LoginVC2.swift
//  TrackTruck
//
//  Created by Grecia Sanchez Perez on 6/5/19.
//  Copyright © 2019 pe.edu.upc. All rights reserved.
//

import UIKit

class LoginVC2: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rucTextField: UITextField!
    
    @IBOutlet weak var usernameTextField2: UITextField!
    @IBOutlet weak var passwordTextField2: UITextField!
    
    @IBOutlet weak var usernameTextField3: UITextField!
    @IBOutlet weak var passwordTextField3: UITextField!
    
    @IBOutlet weak var nameTextField4: UITextField!
    @IBOutlet weak var usernameTextField4: UITextField!
    @IBOutlet weak var passwordTextField4: UITextField!
    @IBOutlet weak var phoneTextField4: UITextField!
    
    @IBOutlet weak var usernameTextField5: UITextField!
    @IBOutlet weak var passwordTextField5: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    func showAlert(with title: String?, message: String?){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(sender: UIButton){
        OperationQueue.main.addOperation {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func registerButtonTapped(sender: UIButton){
        guard let name = nameTextField.text, nameTextField.text != "",
            let pass = passwordTextField.text, passwordTextField.text != "",
            let user = usernameTextField.text, usernameTextField.text != "",
            let ruc = rucTextField.text, rucTextField.text != "" else{
                self.showAlert(with: "Error", message: "Complete los campos")
                return
        }
        AuthService.instance.registerOwner(username: user, password: pass, name: name, ruc: ruc, completion: {Success in
            if Success {
                AuthService.instance.logInOwner(username: user, password: pass, completion: {Success in
                    if Success{
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "logOwner", sender: self)
                            self.showAlert(with: "Exito", message: "Se registro de forma exitosa")
                        }
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
        
        AuthService.instance.logInOwner(username: user, password: pass, completion: {Success in
            if Success{
                //REDIRECCIONAR A MAIN OWNER
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "logOwner", sender: self)
                }
                
            }else{
                OperationQueue.main.addOperation {
                    
                    self.showAlert(with: "Error", message: "Contrasena Incorrecta")
                }
            }
        })
        
    }
    
    @IBAction func login2ButtonTapped(sender: UIButton){
        guard let pass = passwordTextField3.text, passwordTextField3.text != "",
            let user = usernameTextField3.text, usernameTextField3.text != "" else{
                self.showAlert(with: "Error", message: "Complete los campos")
                return
        }
        
        AuthService.instance.logInEmployee(username: user, password: pass, completion: {Success in
            if Success{
                //REDIRECCIONAR A MAIN PARA EMPLOYEE
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "logSeller", sender: self)
                }
            }else{
                    self.showAlert(with: "Error", message: "Contrasena Incorrecta")
            }
        })
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func registerButtonTapped3(sender: UIButton){
        guard let name = nameTextField4.text, nameTextField4.text != "",
            let pass = passwordTextField4.text, passwordTextField4.text != "",
            let user = usernameTextField4.text, usernameTextField4.text != "",
            let phone = phoneTextField4.text, phoneTextField4.text != "" else{
                self.showAlert(with: "Error", message: "Complete los campos")
                return
        }
        AuthService.instance.registerUser(username: user, password: pass, name: name, phone: phone, completion: {Success in
            if Success {
                AuthService.instance.logInUser(username: user, password: pass, completion: {Success in
                    if Success{
                        OperationQueue.main.addOperation {
                            _ = self.navigationController?.popViewController(animated: true)
                        }
                        self.showAlert(with: "Exito", message: "Se registro de forma exitosa")
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
    
    @IBAction func loginButtonTapped3(sender: UIButton){
        guard let pass = passwordTextField5.text, passwordTextField5.text != "",
            let user = usernameTextField5.text, usernameTextField5.text != "" else{
                self.showAlert(with: "Error", message: "Complete los campos")
                return
        }
        
        AuthService.instance.logInUser(username: user, password: pass, completion: {Success in
            if Success{
                OperationQueue.main.addOperation {
                    _ = self.navigationController?.popViewController(animated: true)
                }
                self.showAlert(with: "Exito", message: "Inicio sesion de forma exitosa")
            }else{
                OperationQueue.main.addOperation {
                    self.showAlert(with: "Error", message: "Contrasena Incorrecta")
                }
            }
        })
        
    }
    
}
