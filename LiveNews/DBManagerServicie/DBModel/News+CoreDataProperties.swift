//
//  News+CoreDataProperties.swift
//  LiveNews
//
//  Created by Ghouse Basha Shaik on 25/09/19.
//  Copyright © 2019 Ghouse Basha Shaik. All rights reserved.
//
//

import Foundation
import CoreData


extension News {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<News> {
        return NSFetchRequest<News>(entityName: "News")
    }

    @NSManaged public var title: String?
    @NSManaged public var sourceName: String?
    @NSManaged public var publishedAt: Date?
    @NSManaged public var newsImage: String?
    @NSManaged public var newsContent: String?

}
