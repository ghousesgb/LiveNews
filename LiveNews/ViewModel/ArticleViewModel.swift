//
//  NewsHeadlinesViewModel.swift
//  LiveNews
//
//  Created by Ghouse Basha Shaik on 24/09/19.
//  Copyright © 2019 Ghouse Basha Shaik. All rights reserved.
//

import Foundation

struct ArticleViewModel {
    
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
    
}
