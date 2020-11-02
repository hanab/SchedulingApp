//
//  MockedGamesAPI.swift
//  SchedulingAppTests
//
//  Created by Hana  Demas on 10/31/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//

import Foundation
@testable import SchedulingApp

class MockedGamesAPI:  GateWayProtocol {
    
    //MARK: Properties
    var fetchCalled = false
    
    //MARK: TestCases
    func fetchAllGames(completion: @escaping (GameList) -> Void) {
        fetchCalled = true
    }
    
    func fetchAllGames(url: URL, completion: @escaping (GameList) -> Void) {
       fetchCalled = true
    }
}
