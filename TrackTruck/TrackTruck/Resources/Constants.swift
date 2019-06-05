//
//  Constants.swift
//  TrackTruck
//
//  Created by Grecia Sanchez Perez on 5/31/19.
//  Copyright © 2019 pe.edu.upc. All rights reserved.
//

import Foundation

//Callbacks
//Typealias for callbacks in data service
typealias callback = (_ success: Bool) -> ()

//URLS
let BASE_URL = "http://testmobile1.gear.host/api/"
let GET_FOODTRUCKS="\(BASE_URL)foodtrucks"
let REGISTER_FOODTRUCK="\(BASE_URL)foodtrucks"
let GET_FOODTRUCK="\(BASE_URL)foodtrucks/"
let REGISTER_USER="\(BASE_URL)register/user"
let REGISTER_OWNER="\(BASE_URL)register/owner"
let LOG_USER="\(BASE_URL)login/user"
let LOG_OWNER="\(BASE_URL)login/owner"
let REGISTER_REVIEW = "\(BASE_URL)reviews"
let REGISTER_EMPLOYEE = "\(BASE_URL)employees"
let LOG_EMPLOYEE="\(BASE_URL)login/employee"
let GET_OWNER_SALES="\(BASE_URL)sales"
let REGISTER_SALE = "\(BASE_URL)sales"

//Boolean auth userdefaults keys
let DEFAULTS_REGISTERED="isRegistered"
let DEFAULTS_AUTHENTICATED="isAuthenticated"

let DEFAULTS_USERID="userid"
let DEFAULTS_OWNERID="ownerid"
let DEFAULTS_EMPLOYEEID="employeeid"
let DEFAULTS_TOKEN="authToken"
