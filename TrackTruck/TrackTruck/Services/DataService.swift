//
//  DataService.swift
//  TrackTruck
//
//  Created by Grecia Sanchez Perez on 5/31/19.
//  Copyright © 2019 pe.edu.upc. All rights reserved.
//

import Foundation

protocol DataServiceDelegate : class {
    func trucksLoaded()
    func reviewsLoaded()
    func salesLoaded()
}

class DataService {
    static let instance = DataService()
    
    weak var delegate: DataServiceDelegate?
    var foodtrucks = [Foodtruck]()
    var reviews = [Review]()
    var sales = [Sale]()
    
    //GET all foodtrucks
    func getFoodtrucks(){
        let sessionConfig = URLSessionConfiguration.default
        
        //Create session and optionally set a URLSessionDelegate
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        //Create get request
        guard let URL = URL(string: GET_FOODTRUCKS) else { return }
        var request = URLRequest(url:  URL)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
        if(error==nil){
            //success
            let statusCode = (response as! HTTPURLResponse).statusCode
            print("URL SESSION SUCCEDED : HTTP:\(statusCode)")
            if let data = data {
                    self.foodtrucks = Foodtruck.parseFoodtruckJSONData(data: data)
                    self.delegate?.trucksLoaded()
                }
            }
        else{
            //Failure
            print("Session Failed : \(error!.localizedDescription)")
            }
        })
        
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    
    //GET all sales
    func getSales(){
        let sessionConfig = URLSessionConfiguration.default
        
        //Create session and optionally set a URLSessionDelegate
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        //Create get request
        guard let URL = URL(string: GET_OWNER_SALES) else { return }
        var request = URLRequest(url:  URL)
        request.httpMethod = "GET"
        guard let token = AuthService.instance.authToken else{
            return
        }
        
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if(error==nil){
                //success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL SESSION SUCCEDED : HTTP:\(statusCode)")
                if let data = data {
                    self.sales = Sale.parseSaleJSONData(data: data)
                    self.delegate?.salesLoaded()
                }
            }
            else{
                //Failure
                print("Session Failed : \(error!.localizedDescription)")
            }
        })
        
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    
    //GET all reviews for foodtruck
    func getReviews(for truck: Foodtruck){
        let sessionConfig = URLSessionConfiguration.default
        
        //Create session and optionally set a URLSessionDelegate
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        //Create get request
        guard let URL = URL(string: "\(GET_FOODTRUCK)\(truck.id)") else { return }
        var request = URLRequest(url:  URL)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if(error==nil){
                //success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL SESSION SUCCEDED : HTTP:\(statusCode)")
                if let data = data {
                    self.reviews = Review.parseReviewJSONData(data: data)
                    self.delegate?.reviewsLoaded()
                }
            }
            else{
                //Failure
                print("Session Failed : \(error!.localizedDescription)")
            }
        })
        
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    
    //POST A FOODTRUCK
    func createFoodtruck(name: String, food_type: String, avg_price: Double, latitude: Double, longitude: Double, phone: String, owner_id: Int, completion: @escaping callback){
        
        //Construct JSON
        let json: [String:Any] = [
            "latitude": latitude,
            "longitude": longitude,
            "name": name,
            "food_type": food_type,
            "owner_id": owner_id,
            "avg_price": avg_price,
            "phone_number": phone
        ]
        
        do{
            //Serialize JSON
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            
            let sessionConfig = URLSessionConfiguration.default
            
            let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
            
            guard let URL = URL(string: "\(REGISTER_FOODTRUCK)") else {return}
            
            var request = URLRequest(url: URL)
            request.httpMethod = "POST"
            
            guard let token = AuthService.instance.authToken else{
                completion(false)
                return
            }
            
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.httpBody = jsonData
            
            let task = session.dataTask(with: request, completionHandler:  { (data: Data?, response: URLResponse?, error: Error?) -> Void in
                if(error == nil){
                    //success
                    let statusCode = (response as! HTTPURLResponse).statusCode
                    print("URL SESSION SUCCEDED : HTTP:\(statusCode)")
                    if statusCode != 201{
                        completion(false)
                        return
                    }else{
                        self.getFoodtrucks()
                        completion(true)
                    }
                }else{
                    //Failure
                    print("Session Failed : \(error!.localizedDescription)")
                    completion(false)
                }
            })
            
            task.resume()
            session.finishTasksAndInvalidate()
            
        }catch let err{
            print(err)
        }
    }
    
    
    //POST A REVIEW
    func createReview(foodTruckId: Int, content: String, title: String, userId: Int, completion: @escaping callback){
        
        //Set Date
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDate = format.string(from: date)
        
        //Construct JSON
        let json: [String:Any] = [
            "user_id":userId,
            "foodtruck_id":foodTruckId,
            "content": content,
            "title": title,
            "date": formattedDate
        ]
        
        do{
            //Serialize JSON
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            
            let sessionConfig = URLSessionConfiguration.default
            
            let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
            
            guard let URL = URL(string: "\(REGISTER_REVIEW)") else {return}
            
            var request = URLRequest(url: URL)
            request.httpMethod = "POST"
            
            guard let token = AuthService.instance.authToken else{
                completion(false)
                return
            }
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.httpBody = jsonData 
            let task = session.dataTask(with: request, completionHandler:  { (data: Data?, response: URLResponse?, error: Error?) -> Void in
                if(error == nil){
                    //success
                    let statusCode = (response as! HTTPURLResponse).statusCode
                    print("URL SESSION SUCCEDED : HTTP:\(statusCode)")
                    if statusCode != 201{
                        completion(false)
                        return
                    }else{
                        completion(true)
                    }
                }else{
                    //Failure
                    print("Session Failed : \(error!.localizedDescription)")
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
    
    
    //POST A SALE
    func createSale(employee_id: Int, value: Double, content: String, completion: @escaping callback){
        
        //Set Date
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDate = format.string(from: date)
        
        //Construct JSON
        let json: [String:Any] = [
            "employee_id": employee_id,
            "value": value,
            "date": formattedDate,
            "content" :content
        ]
        
        do{
            //Serialize JSON
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            
            let sessionConfig = URLSessionConfiguration.default
            
            let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
            
            guard let URL = URL(string: "\(REGISTER_SALE)") else {return}
            
            var request = URLRequest(url: URL)
            request.httpMethod = "POST"
            
            guard let token = AuthService.instance.authToken else{
                completion(false)
                return
            }
            
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.httpBody = jsonData
            
            let task = session.dataTask(with: request, completionHandler:  { (data: Data?, response: URLResponse?, error: Error?) -> Void in
                if(error == nil){
                    //success
                    let statusCode = (response as! HTTPURLResponse).statusCode
                    print("URL SESSION SUCCEDED : HTTP:\(statusCode)")
                    if statusCode != 201{
                        completion(false)
                        return
                    }else{
                        completion(true)
                    }
                }else{
                    //Failure
                    print("Session Failed : \(error!.localizedDescription)")
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

    
}
