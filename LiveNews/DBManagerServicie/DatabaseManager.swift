//
//  DatabaseManager.swift
//  LiveNews
//
//  Created by Ghouse Basha Shaik on 25/09/19.
//  Copyright © 2019 Ghouse Basha Shaik. All rights reserved.
//

import Foundation
import CoreData

class DatabaseManager {
    static let shared = DatabaseManager()
    private init() {}
    /**
    Saving Article array into DB
    - Returns:
     - resultHandler with string
    - Parameters:
     - [ArticleViewModel]
    - Author:
     Ghouse Basha Shaik
    */
    
    func saveArticle(articleList: [ArticleViewModel], resultHandler:(String)  -> Void) {
        self.clearAllCoreData()
        for article in articleList {
            let news = News(context: PersistenceService.getCurrentContext())
            news.title          =   article.title
            news.sourceName     =   article.sourceName
            news.publishedAt    =   article.publishedAt
            news.newsImage      =   article.newsImageURL
            news.newsContent    =   article.newsContent
            
            PersistenceService.saveContext()
        }
        resultHandler(SUCCESS)
    }
    
    func fetchNewsArticles() -> [ArticleViewModel] {
        let fetchRequest: NSFetchRequest<News> = News.fetchRequest()
        var articleViewModel = [ArticleViewModel]()
        do{
            let allNewsArticles = try PersistenceService.getCurrentContext().fetch(fetchRequest)
            for articleObj in allNewsArticles {
                let article = Article(source: Source(id: "0", name: articleObj.sourceName ?? ""),
                                      author: "",
                                      title: articleObj.title,
                                      articleDescription: "",
                                      url: "",
                                      urlToImage: articleObj.newsImage ?? "",
                                      publishedAt: articleObj.publishedAt,
                                      content: articleObj.newsContent ?? "")
                articleViewModel.append(ArticleViewModel(article: article))
            }
        }catch{
            
        }
    return articleViewModel
    }
    
    func clearAllCoreData() {
        let entities = PersistenceService.persistentContainer.managedObjectModel.entities // .managedObjectModel.entities
        entities.compactMap({ $0.name }).forEach(clearDeepObjectEntity)
    }

    private func clearDeepObjectEntity(_ entity: String) {
        let context = PersistenceService.getCurrentContext()

        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)

        do {
            try context.execute(deleteRequest)
        } catch {
            print ("There was an error")
        }
    }
}
