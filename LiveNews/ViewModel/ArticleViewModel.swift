//
//  NewsHeadlinesViewModel.swift
//  LiveNews
//
//  Created by Ghouse Basha Shaik on 24/09/19.
//  Copyright © 2019 Ghouse Basha Shaik. All rights reserved.
//

import Foundation

class ArticleViewModel {
    
    var articleViewModel = [ArticleViewModel]()
    
    var title: String = ""
    var sourceName: String = ""
    var publishedAt: Date = Date()
    var newsImageURL: String = ""
    var newsContent: String = ""
    
    init(article: Article? = nil) {
        if let article = article {
            self.title          =   article.title ?? "-"
            self.sourceName     =   article.source?.name ?? "-"
            self.publishedAt    =   article.publishedAt ?? Date()
            self.newsImageURL   =   article.urlToImage ?? ""
            self.newsContent    =   article.content ?? "-"
        }
    }
}

// MARK: - Helper functions for TableViews
extension ArticleViewModel {
    func getNumberOfRowsInSection(section: Int) -> Int {
        return articleViewModel.count
    }
    
    func getArticleAtIndex(index: Int) -> ArticleViewModel {
        return articleViewModel[index]
    }
}

// MARK: - Fetching Data from Service and Local Database
extension ArticleViewModel {
    func fetchDataFromService(resultHandler:@escaping(String)  -> Void) {
        APIServices().fetchNewsHeadlines(successHandler: {[unowned self] (newsViewModel) in
            let art = newsViewModel.articles
            self.articleViewModel = art?.map({return ArticleViewModel(article: $0)}) ?? []
            DatabaseManager.shared.saveArticle(articleList: self.articleViewModel) { (result) in
                self.fetchDataFromDB()
                resultHandler(SUCCESS)
            }
        }) { (failureString) in
                //When API Calling failed due to offline or other issues, lets load data from DB.
                self.fetchDataFromDB()
                resultHandler(SUCCESS)
            }
    }
    
    func fetchDataFromDB() {
        self.articleViewModel = DatabaseManager.shared.fetchNewsArticles()
    }
}
