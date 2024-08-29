//
//  UpcomingLaunch.swift
//  SpaceX
//
//  Created by Kadir Erlik on 27.08.2024.
//

import Foundation

struct Launch: Hashable, Decodable, Identifiable {
    let id: String
    let name: String
    let flightNumber: Int
    let dateLocal: String
    let dateUTC: String
    let rocket: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case flightNumber = "flight_number"
        case dateLocal = "date_local"
        case dateUTC = "date_utc"
        case rocket
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        flightNumber = try container.decode(Int.self, forKey: .flightNumber)
        dateLocal = try container.decode(String.self, forKey: .dateLocal)
        dateUTC = try container.decode(String.self, forKey: .dateUTC)
        rocket = try container.decode(String.self, forKey: .rocket)
    }

    init(id: String, name: String, flightNumber: Int, dateLocal: String, dateUTC: String, rocket: String) {
        self.id = id
        self.name = name
        self.flightNumber = flightNumber
        self.dateLocal = dateLocal
        self.dateUTC = dateUTC
        self.rocket = rocket
    }
}

