//
//  Utilities.swift
//  LiveNews
//
//  Created by Ghouse Basha Shaik on 25/09/19.
//  Copyright © 2019 Ghouse Basha Shaik. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    //Making somepart of text as bold to be used in lables
    class func addBoldText(fullString: String, boldPartOfString: String) -> NSAttributedString {
        let nonBoldFontAttribute = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 12)]
        let boldFontAttribute = [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 14)]
        let boldString = NSMutableAttributedString(string: fullString, attributes:nonBoldFontAttribute)
        boldString.addAttributes(boldFontAttribute, range: (fullString as NSString).range(of: boldPartOfString))
        return boldString
    }
    
    class func getFormattedDate(date: Date, format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: date)
    }
}

