//
//  Review.swift
//  TrackTruck
//
//  Created by Grecia Sanchez Perez on 5/29/19.
//  Copyright © 2019 pe.edu.upc. All rights reserved.
//

import Foundation

struct Review {
    var review_id:Int = 1
    var user_id:Int = 1
    var name: String = ""
    var username:String = ""
    var phone_number:String = ""
    var foodtruck_id:Int = 1
    var content:String = ""
    var title: String = ""
    var date: String = ""

    static func parseReviewJSONData(data: Data)-> [Review]{
        var allReviews = [Review]()
        do{
           let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)

           //parse JSON
            if let reviewList = jsonResult as? [String: Any]{
              let reviews = reviewList["Reviews"] as! [[String: Any]]
                for review in reviews{
                    var newReview = Review()
                    
                    newReview.content = review["content"] as! String
                    newReview.date = review["date"] as! String
                    newReview.title = review["title"] as! String
                    newReview.review_id = review["review_id"] as! Int

                    let foodtruck = review["foodtrucks"] as! [String: Any]
                    newReview.foodtruck_id = foodtruck["foodtruck_id"] as! Int

                    let user = review["users"] as! [String: Any]
                    newReview.user_id = user["user_id"] as! Int
                    newReview.name = user["name"] as! String
                    newReview.username = user["username"] as! String
                    newReview.phone_number = user["phone_number"] as! String

                    allReviews.append(newReview)
                }
            }
        }catch let err{
            print(err)
        }
        return allReviews
    }
}
