//
//  ViewController.swift
//  LiveNews
//
//  Created by Ghouse Basha Shaik on 24/09/19.
//  Copyright © 2019 Ghouse Basha Shaik. All rights reserved.
//

import UIKit

class NewsHomeScreen: UIViewController {
    var articleVM = ArticleViewModel()
    
    @IBOutlet weak var newsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataFromService()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SEQUE_IDENTIFIER.SHOW_NEWS_DETAILS_SEQUE {
            if let indexPath = newsTableView.indexPathForSelectedRow {
                let newsDetailedViewController = segue.destination as! NewsDetailedScreen
                newsDetailedViewController.articalViewModel = articleVM.getArticleAtIndex(index: indexPath.row)
            }
        }
    }
}
// MARK: - Fetching Data from Service and Local Database
extension NewsHomeScreen {
    func fetchDataFromService() {
        ActivityIndicatorUtility.showActivityIndicator(uiView: self.view)
        articleVM.fetchDataFromService(resultHandler: {[unowned self] result in
            DispatchQueue.main.async {[unowned self] in
                ActivityIndicatorUtility.hideActivityIndicator(uiView: self.view)
                self.newsTableView.reloadData()
            }
        })
    }
}
// MARK: - TableView DataSource
extension NewsHomeScreen: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleVM.getNumberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER.NEWS_CELL, for: indexPath) as! NewsTableCell
        cell.articleObj =  articleVM.getArticleAtIndex(index: indexPath.row)
        return cell
    }
}

// MARK: - TableView Delegate
extension NewsHomeScreen: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CELL_HEIGHT.ARTICLE_CELL
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: SEQUE_IDENTIFIER.SHOW_NEWS_DETAILS_SEQUE, sender: indexPath)
    }
}
