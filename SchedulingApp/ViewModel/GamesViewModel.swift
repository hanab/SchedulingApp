//
//  GamesViewModel.swift
//  SchedulingApp
//
//  Created by Hana  Demas on 10/30/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//

import Foundation

class GamesViewModel {
    
    //MARK: Properties
    var gameList:GameList?
    var apiDelegate:GateWayProtocol
    
    //MARK: init
    init(delegate: GateWayProtocol = GamesAPIGetway(session: URLSession.shared)) {
        self.apiDelegate = delegate
    }
    
    //MARK: Methods
    func fetchGames(completion: (() -> ())?) {
        self.apiDelegate.fetchAllGames { [weak self] gameList in
            guard let strongSelf = self else {
                return
            }
            strongSelf.gameList = gameList
            completion?()
        }
    }
    
    func numberOfSections() -> Int {
        guard let gameList = gameList else { return 0}
        
        return gameList.gameSection.count
    }
    
    func sectionHeaderTitle(section: Int) -> String {
        guard let gameList = gameList else { return ""}
        
        return  gameList.gameSection[section].heading
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        guard let gameList = gameList else { return 0}
        
        let section = gameList.gameSection[section].game
        switch section {
        case .gameElement( _):
            return 1
        case .gameElementArray(let games):
            return games.count
        }
    }
    
    func gameAtIndexPathRow(section: Int, indexPath: Int) -> (Team?, GameElement?) {
        let section = gameList?.gameSection[section].game
        var gameElement: GameElement?
        
        switch section {
        case .gameElement(let element):
            gameElement = element
        case .gameElementArray(let games):
            gameElement = games[indexPath]
        default:
            print("no Such case")
        }
        return(gameList?.team, gameElement)
    }
}
