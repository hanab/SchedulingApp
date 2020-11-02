//
//  JsonParsingTest.swift
//  SchedulingAppTests
//
//  Created by Hana  Demas on 10/31/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//

import XCTest
@testable import SchedulingApp

class JsonParsingTest: XCTestCase {
    
   //MARK: setup methodes
    override func setUp() {
        super.setUp()
    }
       
       //MARK: TestCases
    func testJsonParing() {
        let testExpectation =  expectation(description: "fetch games expectation")
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "validGamesJson", withExtension: "json") else {
            XCTFail("Missing file: validGamesJson.json")
            return
        }
        
        let parser = GamesAPIGetway(session:URLSession.shared)
        parser.fetchAllGames(url:url) { (gameList) in
            testExpectation.fulfill()
            XCTAssertEqual(gameList.gameSection.count, 3)
            XCTAssertEqual(gameList.team.name, "EAGLES")
            XCTAssertEqual(gameList.gameSection[0].heading, "PRESEASON")
            XCTAssertEqual(gameList.gameSection[1].heading, "REGULAR SEASON")
            XCTAssertEqual(gameList.gameSection[2].heading, "POSTSEASON")
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
}
