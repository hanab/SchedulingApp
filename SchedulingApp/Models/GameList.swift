//
//  GameList.swift
//  SchedulingApp
//
//  Created by Hana  Demas on 10/28/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//

import Foundation

// MARK: - GamesAndSeasons
struct GamesAndSeasons: Codable {
    
    //MARK: Properties
    let gameList: GameList

    enum CodingKeys: String, CodingKey {
        case gameList = "GameList"
    }
}

// MARK: - GameList
struct GameList: Codable {
    
    //MARK: Properties
    let team: Team
    let defaultGameID: String
    let gameSection: [GameSection]
    let filters: Filters
    let yinzNode: YinzNode

    enum CodingKeys: String, CodingKey {
        case team = "Team"
        case defaultGameID = "DefaultGameId"
        case gameSection = "GameSection"
        case filters = "Filters"
        case yinzNode = "YinzNode"
    }
}

// MARK: - Filters
struct Filters: Codable {
    
    //MARK: Properties
    let filter: Filter

    enum CodingKeys: String, CodingKey {
        case filter = "Filter"
    }
}

// MARK: - Filter
struct Filter: Codable {
    
    //MARK: Properties
    let name, queryParameter, placeholder, current: String
    let filterItems: FilterItems

    enum CodingKeys: String, CodingKey {
        case name = "-Name"
        case queryParameter = "-QueryParameter"
        case placeholder = "-Placeholder"
        case current = "-Current"
        case filterItems = "FilterItems"
    }
}

// MARK: - FilterItems
struct FilterItems: Codable {
    
    //MARK: Properties
    let items: [Item]

    enum CodingKeys: String, CodingKey {
        case items = "Items"
    }
}

// MARK: - Item
struct Item: Codable {
    
    //MARK: Properties
    let id, name: String

    enum CodingKeys: String, CodingKey {
        case id = "-Id"
        case name = "-Name"
    }
}

// MARK: - GameSection
struct GameSection: Codable {
    
    //MARK: Properties
    let heading: String
    let game: GameUnion

    enum CodingKeys: String, CodingKey {
        case heading = "-Heading"
        case game = "Game"
    }
}

enum GameUnion: Codable {
    case gameElement(GameElement)
    case gameElementArray([GameElement])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([GameElement].self) {
            self = .gameElementArray(x)
            return
        }
        if let x = try? container.decode(GameElement.self) {
            self = .gameElement(x)
            return
        }
        throw DecodingError.typeMismatch(GameUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for GameUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .gameElement(let x):
            try container.encode(x)
        case .gameElementArray(let x):
            try container.encode(x)
        }
    }
}

// MARK: - GameElement
struct GameElement: Codable {
    
    //MARK: Properties
    let id: String
    let type: TypeEnum
    let result: String?
    let home, week, label: String
    let venue: String?
    let wlt: Wlt?
    let gameState: GameState?
    let clock, awayScore, homeScore, down: String?
    let isHome: String
    let scheduleHeader: String?
    let date: DateClass?
    let opponent: Opponent?
    let tickets: Tickets?
    let buttons: Buttons?
    let cardData: CardData

    enum CodingKeys: String, CodingKey {
        case id = "-Id"
        case type = "-Type"
        case result = "-Result"
        case home = "-Home"
        case week = "-Week"
        case label = "-Label"
        case venue = "-Venue"
        case wlt = "-WLT"
        case gameState = "-GameState"
        case clock = "-Clock"
        case awayScore = "-AwayScore"
        case homeScore = "-HomeScore"
        case down = "-Down"
        case isHome = "-IsHome"
        case scheduleHeader = "-ScheduleHeader"
        case date = "Date"
        case opponent = "Opponent"
        case tickets = "Tickets"
        case buttons = "Buttons"
        case cardData = "CardData"
    }
}

// MARK: - Buttons
struct Buttons: Codable {
    
    //MARK: Properties
    let button: Button

    enum CodingKeys: String, CodingKey {
        case button = "Button"
    }
}

// MARK: - Button
struct Button: Codable {
    
    //MARK: Properties
    let title: String
    let url: String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case url = "URL"
        case imageURL = "ImageURL"
    }
}

// MARK: - CardData
struct CardData: Codable {
    
    //MARK: Properties
    let clickthroughURL, isDefault: String

    enum CodingKeys: String, CodingKey {
        case clickthroughURL = "ClickthroughURL"
        case isDefault = "IsDefault"
    }
}

// MARK: - DateClass
struct DateClass: Codable {
    
    //MARK: Properties
    let numeric, text, time: String
    let timestamp: String
    let isTBA, isTba: String

    enum CodingKeys: String, CodingKey {
        case numeric = "-Numeric"
        case text = "-Text"
        case time = "-Time"
        case timestamp = "-Timestamp"
        case isTBA = "-IsTBA"
        case isTba = "-IsTba"
    }
}

enum GameState: String, Codable {
    case gameStateFinal = "Final"
}

// MARK: - Opponent
struct Opponent: Codable {
    
    //MARK: Properties
    let triCode, fullName, name, city: String
    let record: String

    enum CodingKeys: String, CodingKey {
        case triCode = "-TriCode"
        case fullName = "-FullName"
        case name = "-Name"
        case city = "-City"
        case record = "-Record"
    }
}

// MARK: - Tickets
struct Tickets: Codable {
    
    //MARK: Properties
    let hasLink: String

    enum CodingKeys: String, CodingKey {
        case hasLink = "-HasLink"
    }
}

enum TypeEnum: String, Codable {
    case b = "B"
    case f = "F"
    case s = "S"
}

enum Wlt: String, Codable {
    case l = "L"
    case w = "W"
}

// MARK: - Team
struct Team: Codable {
    
    //MARK: Properties
    let triCode, fullName, name, city: String
    let record, wins, losses, winPercentage: String

    enum CodingKeys: String, CodingKey {
        case triCode = "-TriCode"
        case fullName = "-FullName"
        case name = "-Name"
        case city = "-City"
        case record = "-Record"
        case wins = "-Wins"
        case losses = "-Losses"
        case winPercentage = "-WinPercentage"
    }
}

// MARK: - YinzNode
struct YinzNode: Codable {
    
    //MARK: Properties
    let inVenue, venueStatus, carrier, ads: String
    let generated: String

    enum CodingKeys: String, CodingKey {
        case inVenue = "-InVenue"
        case venueStatus = "-VenueStatus"
        case carrier = "-Carrier"
        case ads = "-Ads"
        case generated = "-Generated"
    }
}

