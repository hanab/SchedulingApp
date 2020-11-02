//
//  GamesAPI.swift
//  SchedulingApp
//
//  Created by Hana  Demas on 10/28/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//

import Foundation

protocol GateWayProtocol {
    func fetchAllGames( completion: @escaping (GameList) -> Void)
    func fetchAllGames(url: URL, completion: @escaping (GameList) -> Void)
}

class GamesAPIGetway: GateWayProtocol {
    
    //MARK: Properties
    private let session: NetworkSessionProtocol
    private let jsonDecoder: JSONDecoder = JSONDecoder()
    
    //MARK: Init
    init(session: NetworkSessionProtocol) {
        self.session = session
    }
    
    //MARK: Methods
    func fetchAllGames(url: URL, completion: @escaping (GameList) -> Void) {
        let request = URLRequest(url: url)
        let task = session.sessionDataTask(with: request, completionHandler:  { (data, response, error) -> Void in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(GamesAndSeasons.self, from: data).gameList
                    completion(decodedResponse)
                   //added for debugging purpose it could be removed for simplicity
                }  catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                   print("Key '\(key)' not found:", context.debugDescription)
                   print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                   print("Value '\(value)' not found:", context.debugDescription)
                   print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                   print("Type '\(type)' mismatch:", context.debugDescription)
                   print("codingPath:", context.codingPath)
                } catch {
                   print("error: ", error)
               }
            }
        })
        task.resume()
    }
    
    func fetchAllGames( completion: @escaping (GameList) -> Void) {
        let urlString = "http://files.yinzcam.com.s3.amazonaws.com/iOS/interviews/ScheduleExercise/schedule.json"
        let url = URL(string: urlString)!
        
        fetchAllGames(url: url, completion: completion)
    }
}

