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
    
    func saveArticle(articleList: [ArticleViewModel], resultHandler:(String)  -> Void) {
        for article in articleList {
            let news = News(context: PersistenceService.context)
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
            let allNewsArticles = try PersistenceService.context.fetch(fetchRequest)
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
}
