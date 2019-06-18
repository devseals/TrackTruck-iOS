//
//  Foodtruck.swift
//  TrackTruck
//
//  Created by Grecia Sanchez Perez on 5/29/19.
//  Copyright © 2019 pe.edu.upc. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class Foodtruck : NSObject, MKAnnotation{

    var id: Int = 1
    var name: String = ""
    var food_type: String = ""
    var avg_price: Double = 0.0
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var owner_id: Int = 1
    var phone: String = ""

    @objc var title: String?
    @objc var subtitle: String?
    @objc var coordinate: CLLocationCoordinate2D{
        return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }

    static func parseFoodtruckJSONData(data: Data)->[Foodtruck]{
        var allFoodtrucksList = [Foodtruck]()

        do{
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)

            //parse JSON
            if let trucksList = jsonResult as? [String: Any]{
              let foodtrucks = trucksList["Foodtrucks"] as! [[String: Any]]
                for truck in foodtrucks{
                    let newTruck = Foodtruck()
                    newTruck.id = truck["foodtruck_id"] as! Int
                    newTruck.name = truck["name"] as! String
                    newTruck.avg_price = truck["avg_price"] as! Double
                    newTruck.food_type = truck["food_type"] as! String
                    newTruck.longitude = truck["longitude"] as! Double
                    newTruck.latitude = truck["latitude"] as! Double
                    newTruck.phone = truck["phone_number"] as! String

                    let owner = truck["owners"] as! [String: Any]
                    newTruck.owner_id = owner["owner_id"] as! Int

                    newTruck.title = newTruck.name
                    newTruck.subtitle = newTruck.food_type

                    allFoodtrucksList.append(newTruck)
                }
            }
        }catch let err{
            print(err)
        }
        return allFoodtrucksList
    }
}
