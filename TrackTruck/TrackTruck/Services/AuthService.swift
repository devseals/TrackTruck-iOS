//
//  AuthService.swift
//  TrackTruck
//
//  Created by Grecia Sanchez Perez on 6/1/19.
//  Copyright © 2019 pe.edu.upc. All rights reserved.
//

import Foundation

class AuthService{
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    var isRegistered: Bool? {
        get{
            return defaults.bool(forKey: DEFAULTS_REGISTERED) == true
        }
        set{
            defaults.set(newValue, forKey: DEFAULTS_REGISTERED)
        }
    }
    
    var isAuthenticated: Bool? {
        get{
            return defaults.bool(forKey: DEFAULTS_AUTHENTICATED) == true
        }
        set{
            defaults.set(newValue, forKey: DEFAULTS_AUTHENTICATED)
        }
    }
    
    var username: String?{
        get{
            return defaults.value(forKey: DEFAULTS_USERNAME) as? String
        }
        set{
            defaults.value(forKey: DEFAULTS_USERNAME)
        }
    }
    
    var authToken: String?{
        get{
            return defaults.value(forKey: DEFAULTS_TOKEN) as? String
        }
        set{
            defaults.value(forKey: DEFAULTS_TOKEN)
        }
    }
    
    
    func registerUser(username: String, password: String, name: String, phone:String, completion: @escaping callback){
        
        let json = [
            "name": name,
            "password": password,
            "username": username,
            "phone_number": phone]
        
        let sessionConfig = URLSessionConfiguration.default
        
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        guard let URL = URL(string: REGISTER_USER) else{
            isRegistered = false
            completion(false)
            return
        }
        
        var request = URLRequest(url: URL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: json, options: [])
            
            let task = session.dataTask(with: request, completionHandler:  { (data: Data?, response: URLResponse?, error: Error?) -> Void in
                if(error == nil){
                    //Success
                    let statusCode = (response as! HTTPURLResponse).statusCode
                    print("URL SESSION TASK SUCCEDED: HTTP \(statusCode)")
                    
                    if statusCode != 200 && statusCode !=  409 {
                        self.isRegistered = false
                        completion(false)
                        return
                    }else{
                        self.isRegistered = true
                        completion(true)
                    }
                    
                }else{
                 //Failure
                    print("URL SESSION TASK FAILED : \(error!.localizedDescription)")
                    completion(false)
                }
            })
            
            task.resume()
            session.finishTasksAndInvalidate()
            
        }catch let err{
            print(err)
            self.isRegistered = false
            completion(false)
        }
    }
    
    func registerOwner(username: String, password: String, name: String, ruc :String, completion: @escaping callback){
        
        let json = [
            "name": name,
            "password": password,
            "username": username,
            "ruc": ruc]
        
        let sessionConfig = URLSessionConfiguration.default
        
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        guard let URL = URL(string: REGISTER_OWNER) else{
            isRegistered = false
            completion(false)
            return
        }
        
        var request = URLRequest(url: URL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: json, options: [])
            
            let task = session.dataTask(with: request, completionHandler:  { (data: Data?, response: URLResponse?, error: Error?) -> Void in
                if(error == nil){
                    //Success
                    let statusCode = (response as! HTTPURLResponse).statusCode
                    print("URL SESSION TASK SUCCEDED: HTTP \(statusCode)")
                    
                    if statusCode != 200 && statusCode !=  409 {
                        self.isRegistered = false
                        completion(false)
                        return
                    }else{
                        self.isRegistered = true
                        completion(true)
                    }
                    
                }else{
                    //Failure
                    print("URL SESSION TASK FAILED : \(error!.localizedDescription)")
                    completion(false)
                }
            })
            
            task.resume()
            session.finishTasksAndInvalidate()
            
        }catch let err{
            print(err)
            self.isRegistered = false
            completion(false)
        }
    }
    
    
    func registerEmployee(username: String, password: String, name: String, owner_id :Int, completion: @escaping callback){
        
        let json = [
            "name": name,
            "password": password,
            "username": username,
            "owner_id": owner_id] as [String : Any]
        
        let sessionConfig = URLSessionConfiguration.default
        
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        guard let URL = URL(string: REGISTER_OWNER) else{
            completion(false)
            return
        }
        
        var request = URLRequest(url: URL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: json, options: [])
            
            let task = session.dataTask(with: request, completionHandler:  { (data: Data?, response: URLResponse?, error: Error?) -> Void in
                if(error == nil){
                    //Success
                    let statusCode = (response as! HTTPURLResponse).statusCode
                    print("URL SESSION TASK SUCCEDED: HTTP \(statusCode)")
                    
                    if statusCode != 200 && statusCode !=  409 {
                        completion(false)
                        return
                    }else{
                        completion(true)
                    }
                    
                }else{
                    //Failure
                    print("URL SESSION TASK FAILED : \(error!.localizedDescription)")
                    completion(false)
                }
            })
            
            task.resume()
            session.finishTasksAndInvalidate()
            
        }catch let err{
            print(err)
            completion(false)
        }
    }
    
    
    func logInUser(username: String, password : String, completion : @escaping callback){
        let json = [
            "username": username,
            "password": password]
        
        let sessionConfig = URLSessionConfiguration.default
        
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        guard let URL = URL(string: LOG_USER) else{
            isAuthenticated = false
            completion(false)
            return
        }
        
        var request = URLRequest(url: URL)
        
        request.httpMethod="POST"
        
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: json, options: [])
            
            let task = session.dataTask(with: request, completionHandler:  { (data: Data?, response: URLResponse?, error: Error?) -> Void in
                if(error == nil){
                    //Success
                    let statusCode = (response as! HTTPURLResponse).statusCode
                    print("URL SESSION TASK SUCCEDED: HTTP \(statusCode)")
                    
                    if statusCode != 200{
                        
                        completion(false)
                        return
                    }else{
                        guard let data = data else{
                            completion(false)
                            return
                        }
                        do{
                            let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, AnyObject>
                            if result != nil{
                                if let username = result?["username"] as? String{
                                    if let token = result?["token"] as? String{
                                        //LOGED IN SUCCESSFULY
                                        self.username = username
                                        self.authToken = token
                                        self.isRegistered = true
                                        self.isAuthenticated = true
                                        completion(true)
                                    }else{
                                        completion(false)
                                    }
                                }else{
                                    completion(false)
                                }
                            }else{
                                completion(false)
                            }
                        }catch let err{
                            print(err)
                            completion(false)
                        }
                    }
                }else{
                    //Failure
                    print("URL SESSION TASK FAILED : \(error!.localizedDescription)")
                    completion(false)
                    return
                }
            })
            
            task.resume()
            session.finishTasksAndInvalidate()
            
        }catch let err{
            print(err)
            self.isAuthenticated = false
            completion(false)
        }
    }
    
    func logInOwner(username: String, password : String, completion : @escaping callback){
        let json = [
            "username": username,
            "password": password]
        
        let sessionConfig = URLSessionConfiguration.default
        
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        guard let URL = URL(string: LOG_OWNER) else{
            isAuthenticated = false
            completion(false)
            return
        }
        
        var request = URLRequest(url: URL)
        
        request.httpMethod="POST"
        
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: json, options: [])
            
            let task = session.dataTask(with: request, completionHandler:  { (data: Data?, response: URLResponse?, error: Error?) -> Void in
                if(error == nil){
                    //Success
                    let statusCode = (response as! HTTPURLResponse).statusCode
                    print("URL SESSION TASK SUCCEDED: HTTP \(statusCode)")
                    
                    if statusCode != 200{
                        
                        completion(false)
                        return
                    }else{
                        guard let data = data else{
                            completion(false)
                            return
                        }
                        do{
                            let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, AnyObject>
                            if result != nil{
                                if let username = result?["username"] as? String{
                                    if let token = result?["token"] as? String{
                                        //LOGED IN SUCCESSFULY
                                        self.username = username
                                        self.authToken = token
                                        self.isRegistered = true
                                        self.isAuthenticated = true
                                        completion(true)
                                    }else{
                                        completion(false)
                                    }
                                }else{
                                    completion(false)
                                }
                            }else{
                                completion(false)
                            }
                        }catch let err{
                            print(err)
                            completion(false)
                        }
                    }
                }else{
                    //Failure
                    print("URL SESSION TASK FAILED : \(error!.localizedDescription)")
                    completion(false)
                    return
                }
            })
            
            task.resume()
            session.finishTasksAndInvalidate()
            
        }catch let err{
            print(err)
            self.isAuthenticated = false
            completion(false)
        }
    }
    
    func logInEmployee(username: String, password : String, completion : @escaping callback){
        let json = [
            "username": username,
            "password": password]
        
        let sessionConfig = URLSessionConfiguration.default
        
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        guard let URL = URL(string: LOG_EMPLOYEE) else{
            isAuthenticated = false
            completion(false)
            return
        }
        
        var request = URLRequest(url: URL)
        
        request.httpMethod="POST"
        
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: json, options: [])
            
            let task = session.dataTask(with: request, completionHandler:  { (data: Data?, response: URLResponse?, error: Error?) -> Void in
                if(error == nil){
                    //Success
                    let statusCode = (response as! HTTPURLResponse).statusCode
                    print("URL SESSION TASK SUCCEDED: HTTP \(statusCode)")
                    
                    if statusCode != 200{
                        
                        completion(false)
                        return
                    }else{
                        guard let data = data else{
                            completion(false)
                            return
                        }
                        do{
                            let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, AnyObject>
                            if result != nil{
                                if let username = result?["username"] as? String{
                                    if let token = result?["token"] as? String{
                                        //LOGED IN SUCCESSFULY
                                        self.username = username
                                        self.authToken = token
                                        self.isRegistered = true
                                        self.isAuthenticated = true
                                        completion(true)
                                    }else{
                                        completion(false)
                                    }
                                }else{
                                    completion(false)
                                }
                            }else{
                                completion(false)
                            }
                        }catch let err{
                            print(err)
                            completion(false)
                        }
                    }
                }else{
                    //Failure
                    print("URL SESSION TASK FAILED : \(error!.localizedDescription)")
                    completion(false)
                    return
                }
            })
            
            task.resume()
            session.finishTasksAndInvalidate()
            
        }catch let err{
            print(err)
            self.isAuthenticated = false
            completion(false)
        }
    }
    
}