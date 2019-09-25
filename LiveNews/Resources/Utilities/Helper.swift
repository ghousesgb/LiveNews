//
//  Helper.swift
//  LiveNews
//
//  Created by Ghouse Basha Shaik on 25/09/19.
//  Copyright © 2019 Ghouse Basha Shaik. All rights reserved.
//

import Foundation
import UIKit

class TableViewHelper {
    class func EmptyMessage(message:String, tableView:UITableView) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width-32, height: tableView.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = UIColor.black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.sizeToFit()
        tableView.backgroundView = messageLabel
    }
}

