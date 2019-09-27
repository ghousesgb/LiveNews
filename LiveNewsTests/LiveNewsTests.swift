//
//  LiveNewsTests.swift
//  LiveNewsTests
//
//  Created by Ghouse Basha Shaik on 24/09/19.
//  Copyright © 2019 Ghouse Basha Shaik. All rights reserved.
//

import XCTest
@testable import LiveNews

class LiveNewsTests: XCTestCase {
    
    func testCheckingCountOfRecords() {
        let articleVM = ArticleViewModel()
        
        articleVM.fetchDataFromService { (result) in
            let articleViewModelCount = articleVM.articleViewModel.count
            let getNumberOfRowsInSeciont = articleVM.getNumberOfRowsInSection(section: 0)
            
            XCTAssertTrue(articleViewModelCount == getNumberOfRowsInSeciont, "testCheckingCountOfRecords() succeeded")
        }
    }

}
