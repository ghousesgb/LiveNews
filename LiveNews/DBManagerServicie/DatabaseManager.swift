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
        //Checking API Records with Local DB,
        //If Local DB has the records UPDATE it
        //if Local DB doesn't have the record SAVE it
        for article in articleList {
            let fetchRequest: NSFetchRequest<News> = News.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "title = %@ AND sourceName = %@", article.title, article.sourceName)
            
            do {
                let searchArticles = try PersistenceService.getCurrentContext().fetch(fetchRequest)
                if searchArticles.count > 0 {
                    updateExistingArticle(article: searchArticles.first!)
                }else {
                    saveNewArticle(article: article)
                }
            }catch{
                print(error)
            }
        }
        
        //Checking Local Records with API Records
        //If Local Record is not available in API Recrods DELETE
        let fetchRequest: NSFetchRequest<News> = News.fetchRequest()
        do{
            let allNewsArticles = try PersistenceService.getCurrentContext().fetch(fetchRequest)
            for articleObj in allNewsArticles {
                if !articleList.contains(where: { (article) in
                    let dbArticleString  = "\(article.title) \(article.sourceName)"
                    let apiArticleString = "\(articleObj.title ?? "") \(articleObj.sourceName ?? "")"
                    if dbArticleString == apiArticleString { return true }
                    return false
                }) {
                    deleteExistingArticle(article : articleObj)
                }
            }
        }catch{
            
        }
        resultHandler(SUCCESS)
    }
    
    func saveNewArticle(article: ArticleViewModel) {
        let news = News(context: PersistenceService.getCurrentContext())
        news.title          =   article.title
        news.sourceName     =   article.sourceName
        news.publishedAt    =   Utilities.getFormattedDate(date: article.publishedAt, format: DATE_FORMATS.PUBLISH_AT_FORMAT)
        news.newsImage      =   article.newsImageURL
        news.newsContent    =   article.newsContent
        
        PersistenceService.saveContext()
    }
    
    func updateExistingArticle(article: News) {
        let news = News(context: PersistenceService.getCurrentContext())
        news.title          =   article.title
        news.sourceName     =   article.sourceName
        news.publishedAt    =   article.publishedAt
        news.newsImage      =   article.newsImage
        news.newsContent    =   article.newsContent
        
        PersistenceService.saveContext()
    }
    
    func deleteExistingArticle(article: News) {
        PersistenceService.getCurrentContext().delete(article)
        PersistenceService.saveContext()
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
                                      publishedAt: Utilities.getFormattedDate(date: articleObj.publishedAt, format: DATE_FORMATS.PUBLISH_AT_FORMAT),
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
