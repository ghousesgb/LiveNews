//
//  Constants.swift
//  LiveNews
//
//  Created by Ghouse Basha Shaik on 24/09/19.
//  Copyright © 2019 Ghouse Basha Shaik. All rights reserved.
//

import Foundation
import UIKit

let NEWS_API_KEY = "36147d4ea82747cd86d9428b94001272"
let HEADLINES_URL = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=" + NEWS_API_KEY

let SUCCESS = "SUCCESS"
let FAILURE = "FAILURE"

struct CustomError {
    static let msgInvalidUsernameAndPassword = "Incorrect Username or Password, try again."
    static let msgNetworkError = "Network Failed"
    static let msgJsonParsingIssue = "Issue in Parsing Json"
    static let msg400Error = "400 Error"
}

struct ALERT_MESSAGES {
    static let TITLE_PROBLEM = "PROBLEM"
    static let ALERT_OK_TITLE = "OK"
    static let ALERT_CANCEL_TITLE = "Cancel"
}

struct CELL_IDENTIFIER {
    static let NEWS_CELL = "newsCell"
}

struct DATE_FORMATS {
    static let PUBLISH_AT_FORMAT = "yyyy-MM-dd"
}

struct CELL_HEIGHT {
    static let ARTICLE_CELL:CGFloat = 188.0
}
