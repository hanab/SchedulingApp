//
//  ViewModelTest.swift
//  SchedulingAppTests
//
//  Created by Hana  Demas on 10/31/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//

import XCTest
@testable import SchedulingApp

class ViewModelTest: XCTestCase {

    //MARK: Properties
    var viewModel:GamesViewModel!
    let gateWay = MockedGamesAPI()
    
    //MARK: setup methodes
    override func setUp() {
        super.setUp()
        viewModel = GamesViewModel(delegate: gateWay)
    }
    
    //MARK: TestCases
    func testFetchCalled() {
        viewModel.fetchGames {
            XCTAssertTrue(self.gateWay.fetchCalled)
        }
    }
    
    func testNumberOfGameSections() {
        XCTAssertEqual(self.viewModel.numberOfSections(), 0)
    }
}
