//
//  FightResponse.swift
//  bet-rave
//
//  Created by Eric Chandonnet on 2024-07-25.
//

import Foundation

struct FightResponse: Codable {
    let response: [Fight]
}

struct Fight: Codable {
    let id: Int
    let date: String
    let time: String
    let timestamp: Int
    let timezone: String
    let slug: String
    let category: String
    let fighters: Fighters
}

extension Fight {
    struct Fighters: Codable {
        let first: Fighter
        let second: Fighter
    }
    
    struct Fighter: Codable {
        let id: Int
        let name: String
        let logo: String
        let winner: Bool
    }
}
