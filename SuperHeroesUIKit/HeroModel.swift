//
//  HeroModel.swift
//  SuperHeroesUIKit
//
//  Created by Админ on 27.07.2024.
//

import Foundation

struct Hero: Codable, Hashable, Identifiable {
    let id: Int
    
    let name:String
    let category: HeroCategory
    let stats: HeroStats
    
    enum HeroCategory: String, Codable, CaseIterable {
        case superheroes = "superheroes"
        case supervillains = "supervillains"
    }
    
    struct HeroStats: Codable, Hashable {
        let intelligence: Int
        let power: Int
        let speed: Int
        let endurance: Int
        let reaction: Int
        let protection: Int
    }
}




