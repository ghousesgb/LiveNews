//
//  News+CoreDataProperties.swift
//  LiveNews
//
//  Created by Ghouse Basha Shaik on 30/09/19.
//  Copyright © 2019 Ghouse Basha Shaik. All rights reserved.
//
//

import Foundation
import CoreData


extension News {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<News> {
        return NSFetchRequest<News>(entityName: "News")
    }

    @NSManaged public var newsContent: String?
    @NSManaged public var newsImage: String?
    @NSManaged public var publishedAt: String?
    @NSManaged public var sourceName: String?
    @NSManaged public var title: String?

}
