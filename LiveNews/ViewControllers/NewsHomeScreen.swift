//
//  ViewController.swift
//  LiveNews
//
//  Created by Ghouse Basha Shaik on 24/09/19.
//  Copyright © 2019 Ghouse Basha Shaik. All rights reserved.
//

import UIKit

struct structExample {
    var age: Int
    
    mutating func updateAge() {
        age += 5
    }
}
class classExample {
    var age: Int = 0
    
    func updateAge() {
        age += 5
    }
}

class NewsHomeScreen: UIViewController {
    var articleVM = ArticleViewModel()
    
    @IBOutlet weak var newsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let arrayExample = [10, 20, 40]
        let tupleExample = (age: 108, name: "Hello")
        let dictExample:[String: Any]  = ["age": 10, "name": "Raj"]
        print(arrayExample[0])
        print(tupleExample.age)
        print(dictExample["age"] as! Int)
        
        let multipleString = #"""
                            you can "raw"
                            on multiple lines
                            with swift 5. name = \#(dictExample["name"]!)
                            """#
        let hashTagString = ##" "hashtag" #Swift 5"##
        
        print(multipleString)
        print(hashTagString)

        var s1 = structExample(age: 0)
        let c1 = classExample()
        print(s1.age, " ", c1.age)
        s1.age = 10
        c1.age = 10
        print(s1.age, " ", c1.age)
        let s2 = s1
        let c2 = c1
        print(s2.age, " ", c2.age)
        s1.age = 20
        c1.age = 20
        print(s2.age, " ", c2.age)
        
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
