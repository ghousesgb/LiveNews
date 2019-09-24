//
//  APIRequest.swift
//  LiveNews
//
//  Created by Ghouse Basha Shaik on 24/09/19.
//  Copyright © 2019 Ghouse Basha Shaik. All rights reserved.
//

import Foundation
class APIRequest {
    var urlString : String = ""
    var httpMethod : String = "GET"
    var headers : [String:String]? = ["Accept":"application/json"]
    var parameters:  [String:Any]? = nil //[:] //AnyObject?
    var httpBody: Data? = nil
}
