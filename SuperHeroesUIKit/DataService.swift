//
//  DataService.swift
//  SuperHeroesUIKit
//
//  Created by Админ on 27.07.2024.
//

import UIKit


class DataService {
    
    static let shared = DataService()
    
    var heroes: [HeroModel] = []
    
    private init() {}
    
    init(heroes: [HeroModel]) {
        self.heroes = heroes
    }
    
    func changeFavorite(id: Int, isFavorite: Bool) -> Void {
        heroes = heroes.map { hero in
            if hero.id == id {
                return HeroModel(id: id,
                                 name: hero.name,
                                 category: hero.category,
                                 stats: hero.stats,
                                 isFavorite: isFavorite,
                                 imageURL: hero.imageURL,
                                 color: hero.color)
            } else {
                return hero
            }
        }
    }
}




