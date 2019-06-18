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
    var value: Double = 0.0

    static func parseSaleJSONData(data: Data)-> [Sale] {
       var allSales = [Sale]()

        do{
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)

            //parse JSON
            if let saleList = jsonResult as? [String: Any]{
                let sales = saleList["SalesRecords"] as! [[String: Any]]
                for sale in sales{
                    var newSale = Sale()
                    newSale.value = sale["value"] as! Double
                    newSale.content = sale["content"] as! String
                    newSale.date = sale["date"] as! String

                    let employee = sale["employees"] as! [String: Any]
                    newSale.employeeName = employee["name"] as! String
                    
                    let owner = employee["owners"] as! [String: Any]
                    let thisId = owner["owner_id"] as! Int
                    
                    if(thisId == AuthService.instance.ownerId){
                    allSales.append(newSale)
                    }
        
                }
            }
        }catch let err{
            print(err)
        }
        return allSales
    }

}
