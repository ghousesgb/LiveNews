//
//  ViewController.swift
//  LiveNews
//
//  Created by Ghouse Basha Shaik on 24/09/19.
//  Copyright © 2019 Ghouse Basha Shaik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var articleViewModel = [ArticleViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    func fetchData() {
        APIServices().fetchNewsHeadlines(successHandler: {[unowned self] (newsViewModel) in
            let art = newsViewModel.articles
            self.articleViewModel = art?.map({return ArticleViewModel(article: $0)}) ?? []
            DispatchQueue.main.async {
                //
            }
        }) { (failureString) in
            Alert().showAlert(ALERT_MESSAGES.TITLE_PROBLEM, message: failureString, okButtonTitle: ALERT_MESSAGES.ALERT_OK_TITLE, CompletionHandler: nil, View: self)
        }
    }
}



