//
//  HeroModel.swift
//  SuperHeroesUIKit
//
//  Created by Админ on 27.07.2024.
//


import UIKit

struct HeroModel: Codable, Hashable, Identifiable {
    var id: Int
    
    var name:String
    var category: HeroCategory
    var stats: HeroStats
    var isFavorite: Bool
    var imageURL: String
    var color: RGBAColor
    
    enum HeroCategory: String, Codable, CaseIterable {
        case superheroes = "superheroes"
        case supervillains = "supervillains"
    }
    
    struct HeroStats: Codable, Hashable {
        var intelligence: Int
        var power: Int
        var speed: Int
        var endurance: Int
        var reaction: Int
        var protection: Int
    }
    
    struct RGBAColor: Codable, Hashable {
        
        var red: Double
        var green: Double
        var blue: Double
        var alpha: Double
        
        var outputColor: UIColor {
            return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha)
        }
    }
}




