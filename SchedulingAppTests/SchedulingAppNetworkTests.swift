//
//  SchedulingAppTests.swift
//  SchedulingAppTests
//
//  Created by Hana  Demas on 10/28/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//

import XCTest
@testable import SchedulingApp

class SchedulingAppNetworkTests: XCTestCase {

    //MARK: Properties
    var gamesAPI:GamesAPIGetway!
    var session = MockURLSession()
    
    override func setUp() {
        super.setUp()
        gamesAPI = GamesAPIGetway(session: session)
    }

    //MARK: TestCases
    func testDataTaskResumeCalled() {
        let dataTask = MockURLSessionDataTask()
        session.mockDataTask = dataTask
        
        gamesAPI.fetchAllGames { (gameList) in
            //nothing to do with the results for this test
        }
        XCTAssert(dataTask.resumeWasCalled)
    }

    func testDataTaskUrlSet() {
        let dataTask = MockURLSessionDataTask()
        session.mockDataTask = dataTask
        
        guard let url = URL(string: "https://myurl") else {
            fatalError("URL can't be empty")
        }
        
        gamesAPI.fetchAllGames(url: url, completion: {(gameList) in
            //nothing to do with the results for this test
        })
        XCTAssert((session.mockURL == url))
    }
}
