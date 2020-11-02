//
//  GameListViewControllerTest.swift
//  SchedulingAppTests
//
//  Created by Hana  Demas on 10/31/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//

import XCTest
@testable import SchedulingApp

class GameListViewControllerTest: XCTestCase {
    
    //MARK:Properies
    var gameListViewController:GamesListViewController!
    
    //MARK:setup methodes
    override func setUp() {
        super.setUp()
        
        gameListViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "list") as? GamesListViewController
        gameListViewController?.loadView()
    }
    
    //MARK: TestCases
    func testTableViewExists() {
        XCTAssertNotNil(gameListViewController.gamesTableView)
    }
    
    func testRefreshCotrolExists() {
        XCTAssertNotNil(gameListViewController?.refreshControl)
    }
    
    func testNavigationTitleSet(){
        gameListViewController?.viewDidLoad()
        XCTAssertEqual(gameListViewController?.navigationItem.title, "SCHEDULE")
    }
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(gameListViewController.gamesTableView.delegate)
    }
    
    func testTableViewConfromsToTableViewDelegateProtocol() {
        XCTAssertTrue(gameListViewController.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(gameListViewController.responds(to: #selector(gameListViewController.tableView(_:viewForHeaderInSection:))))
        XCTAssertTrue(gameListViewController.responds(to: #selector(gameListViewController.tableView(_:heightForHeaderInSection:))))
        XCTAssertTrue(gameListViewController.responds(to: #selector(gameListViewController.tableView(_:heightForRowAt:))))
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(gameListViewController.gamesTableView.dataSource)
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(gameListViewController.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(gameListViewController.responds(to: #selector(gameListViewController.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(gameListViewController.responds(to: #selector(gameListViewController.tableView(_:cellForRowAt:))))
    }
}
