//
//  ServiceManager.swift
//  LiveNews
//
//  Created by Ghouse Basha Shaik on 24/09/19.
//  Copyright © 2019 Ghouse Basha Shaik. All rights reserved.
//

import Foundation

class ServiceManager {
    private init() {}
    static let shared = ServiceManager()
    
    func makeAPICalls(apiRequest: APIRequest,  completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        
        //Making a API Call
        let config = URLSessionConfiguration.ephemeral
        if let headers = apiRequest.headers {
            config.httpAdditionalHeaders = headers
        }
        let session = URLSession(configuration: config)
        
        let HTTPHeaderField_ContentType         = "content-type"
        let ContentType_ApplicationJson         = "application/json"
        let HTTPMethod_Get                      = apiRequest.httpMethod
        
        let callURL = URL.init(string: apiRequest.urlString)
        var request = URLRequest.init(url: callURL!)
        request.timeoutInterval = 60.0 // TimeoutInterval in Second
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        request.httpMethod = HTTPMethod_Get
        
        if let httpBody = apiRequest.httpBody {
            request.httpBody = httpBody as Data//httpBody.dataUsingEncoding(NSUTF8StringEncoding)
        }
        if let parameters = apiRequest.parameters, parameters.count > 0 {
            request.addValue(ContentType_ApplicationJson, forHTTPHeaderField: HTTPHeaderField_ContentType)
            do {
                let json = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) as Data
                print(json)
                if let jsonString = String(data: json, encoding: .utf8) {
                    print(jsonString)
                }
                request.httpBody = json
            } catch {
                print(error.localizedDescription)
            }
        }
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, err) in
            completion(data, response, err)
        }
        task.resume()
    }
}
