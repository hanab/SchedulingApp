//
//  GameTableViewCell.swift
//  SchedulingApp
//
//  Created by Hana  Demas on 10/29/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//

import UIKit

class GameTableViewCell: UITableViewCell {
    
    //MARK Properties
    @IBOutlet var weekLabel: UILabel!
    @IBOutlet var opponentTeamName: UILabel!
    @IBOutlet var homeTeamName: UILabel!
    @IBOutlet var homeTeamScore: UILabel!
    @IBOutlet var opponentTeamScore: UILabel!
    @IBOutlet var homeTeamIcon: UIImageView!
    @IBOutlet var opponentTeamIcon: UIImageView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    //MARK: Methods
    private func getImageUrlFromTricode(tricode: String) -> String  {
        return"http://yc-app-resources.s3.amazonaws.com/nfl/logos/nfl_" + tricode.lowercased() + "_light.png"
    }
    
    private func setupFont() {
        homeTeamScore.font = UIFont(name: "MavenProRegular", size: 14)!
        homeTeamScore.textColor =  UIColor.yinzGray()
        opponentTeamScore.font = UIFont(name: "MavenProRegular", size: 14)!
        opponentTeamScore.textColor =  UIColor.yinzGray()
    }
    
    func setUPViews(team: Team, game: GameElement) {
        homeTeamName.text = team.name
        opponentTeamName.text = game.opponent?.name ?? ""
        weekLabel.text = game.week
        homeTeamIcon.loadImageUsingCacheWithURLString(getImageUrlFromTricode(tricode: team.triCode), placeHolder: UIImage(named: "list_header"))
        opponentTeamIcon.loadImageUsingCacheWithURLString(getImageUrlFromTricode(tricode: game.opponent?.triCode ?? ""), placeHolder: UIImage(named: "list_header"))
        
        let dateString = game.date?.timestamp
        let dateFromString = dateString?.getDateFromString()
        let formattedDate = dateFromString?.getFormattedDate()
        dateLabel.text = formattedDate ?? ""
        
        switch game.type {
        case .f:
            homeTeamScore.text = game.homeScore
            opponentTeamScore.text = game.awayScore
            timeLabel.text = game.gameState?.rawValue ?? ""
        case .s:
            homeTeamScore.text = team.record
            opponentTeamScore.text = game.opponent?.record ?? ""
            setupFont()
            timeLabel.text = dateFromString?.getFormatedHours() ?? ""
        default:
            print("not applicable")
        }
    }
}
