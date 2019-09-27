//
//  APIServices.swift
//  LiveNews
//
//  Created by Ghouse Basha Shaik on 24/09/19.
//  Copyright © 2019 Ghouse Basha Shaik. All rights reserved.
//

import Foundation

class APIServices {
    typealias successHandler = (NewsHeadlinesModel)  -> Void
    typealias failureHandler = (String) -> Void
    
    func fetchNewsHeadlines(successHandler:@escaping successHandler, failureHandler:@escaping  failureHandler) {
        
        let apiRequest = APIRequest()
        apiRequest.urlString = HEADLINES_URL
        
        ServiceManager.shared.makeAPICalls(apiRequest: apiRequest) { (data, response, error) in
            if let response = response {
                guard error == nil else {
                    failureHandler(CustomError.msgNetworkError)
                    return
                }
                if response.getStatusCode()! == 400 {
                    failureHandler(CustomError.msg400Error)
                }else {
                    do {
                        let newsModel = try NewsHeadlinesModel.init(data: data!)
                        successHandler(newsModel)
                    }catch {
                        failureHandler(CustomError.msgJsonParsingIssue)
                    }
                }
            }else {
                failureHandler(CustomError.msgNetworkError)
            }
        }
    }
}
