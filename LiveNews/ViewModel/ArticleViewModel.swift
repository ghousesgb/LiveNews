//
//  NewsHeadlinesViewModel.swift
//  LiveNews
//
//  Created by Ghouse Basha Shaik on 24/09/19.
//  Copyright © 2019 Ghouse Basha Shaik. All rights reserved.
//

import Foundation

class ArticleViewModel {
    
    let title: String
    let sourceName: String
    let publishedAt: Date
    let newsImageURL: String
    let newsContent: String
    
    init(article: Article) {
        self.title          =   article.title ?? "-"
        self.sourceName     =   article.source?.name ?? "-"
        self.publishedAt    =   article.publishedAt ?? Date()
        self.newsImageURL   =   article.urlToImage ?? ""
        self.newsContent    =   article.content ?? "-"
    }
    
    func fetchData(successHandler:@escaping(NewsHeadlinesModel)  -> Void, failureHandler:@escaping (String) -> Void) {
        APIServices().fetchNewsHeadlines(successHandler: {[unowned self] (newsViewModel) in
            let art = newsViewModel.articles
            let articleViewModel = art?.map({return ArticleViewModel(article: $0)}) ?? []
            successHandler(articleViewModel)
        }) { (failureString) in
            failureHandler(failureString)
        }
    }
}
