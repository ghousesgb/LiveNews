//
//  ViewController.swift
//  LiveNews
//
//  Created by Ghouse Basha Shaik on 24/09/19.
//  Copyright © 2019 Ghouse Basha Shaik. All rights reserved.
//

import UIKit

class NewsHomeScreen: UIViewController {

    var articleViewModel = [ArticleViewModel]()
    @IBOutlet weak var newsTableView: UITableView!
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataFromService()
    }
    
    func fetchDataFromService() {
        ActivityIndicatorUtility.showActivityIndicator(uiView: self.view)
        APIServices().fetchNewsHeadlines(successHandler: {[unowned self] (newsViewModel) in
            let art = newsViewModel.articles
            self.articleViewModel = art?.map({return ArticleViewModel(article: $0)}) ?? []
            DatabaseManager.shared.saveArticle(articleList: self.articleViewModel) { (result) in
                DispatchQueue.main.async {
                    ActivityIndicatorUtility.hideActivityIndicator(uiView: self.view)
                    self.fetchDataFromDB()
                }
            }
        }) { (failureString) in
            DispatchQueue.main.async {[unowned self] in
                ActivityIndicatorUtility.hideActivityIndicator(uiView: self.view)
                //When API Calling failed due to offline or other issues, lets load data from DB.
                self.fetchDataFromDB()
                //Alert().showAlert(ALERT_MESSAGES.TITLE_PROBLEM, message: failureString, okButtonTitle: ALERT_MESSAGES.ALERT_OK_TITLE, CompletionHandler: nil, View: self)
            }
        }
    }
    
    func fetchDataFromDB() {
        DispatchQueue.main.async {[unowned self] in
            self.articleViewModel = DatabaseManager.shared.fetchNewsArticles()
            self.newsTableView.reloadData()
        }
    }
}

extension NewsHomeScreen: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER.NEWS_CELL, for: indexPath) as! NewsTableCell
        let articleObj = articleViewModel[indexPath.row]
        cell.articleObj = articleObj
        return cell
    }
}

extension NewsHomeScreen: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CELL_HEIGHT.ARTICLE_CELL
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
