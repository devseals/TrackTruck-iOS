//
//  Sale.swift
//  TrackTruck
//
//  Created by Grecia Sanchez Perez on 5/29/19.
//  Copyright © 2019 pe.edu.upc. All rights reserved.
//

import Foundation

struct Sale{
    var employeeName: String = ""
    var content: String = ""
    var date: String = ""
    var amount: Double = 0.0
    
    static func parseSaleJSONData(data: Data)-> [Sale] {
       var allsales = [Sale]()
        
        do{
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            
            //parse JSON
            if let saleList = jsonResult as? [Dictionary<String,AnyObject>]{
                let sales = saleList[2] as! [Dictionary<String,AnyObject>]
                for sale in sales{
                    var newSale = Sale()
                    newSale.amount = sale["value"] as! Double
                    newSale.content = sale["content"] as! String
                    newSale.date = sale["date"] as! String
                    
                    let employee = sale["employees"] as! Dictionary<String,AnyObject>
                    newSale.employeeName = employee["name"] as! String
                    
                    allsales.append(newSale)
                }
            }
        }catch let err{
            print(err)
        }
        return allsales
    }
    
}
