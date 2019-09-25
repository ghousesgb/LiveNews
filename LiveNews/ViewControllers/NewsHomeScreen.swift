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
        fetchData()
    }
    
    func fetchData() {
        ActivityIndicatorUtility.showActivityIndicator(uiView: self.view)
        
        
        
        
        
        APIServices().fetchNewsHeadlines(successHandler: {[unowned self] (newsViewModel) in
            let art = newsViewModel.articles
            self.articleViewModel = art?.map({return ArticleViewModel(article: $0)}) ?? []
            DispatchQueue.main.async {
                ActivityIndicatorUtility.hideActivityIndicator(uiView: self.view)
                self.newsTableView.reloadData()
            }
        }) { (failureString) in
            DispatchQueue.main.async {
                ActivityIndicatorUtility.hideActivityIndicator(uiView: self.view)
                Alert().showAlert(ALERT_MESSAGES.TITLE_PROBLEM, message: failureString, okButtonTitle: ALERT_MESSAGES.ALERT_OK_TITLE, CompletionHandler: nil, View: self)
            }
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


