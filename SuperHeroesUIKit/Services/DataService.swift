//
//  DataService.swift
//  SuperHeroesUIKit
//
//  Created by Админ on 27.07.2024.
//

import UIKit

// MARK: - DataService

class DataService {
    
    // MARK: - Properties
    
    static let shared = DataService()
    
    var heroes: [HeroModel] = [] {
        didSet {
            NotificationCenter.default.post(name: Notification.Name("heroesUpdated"), object: nil)
        }
    }
    
    // MARK: - Initializers
    
    private init() {}
    
    init(heroes: [HeroModel]) {
        self.heroes = heroes
    }
    
    // MARK: - Useful
    
    func changeFavorite(id: Int, isFavorite: Bool) -> Void {
        self.heroes = heroes.map { hero in
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
    
    func getHeroById(by id: Int) -> HeroModel {
        let hero: HeroModel = heroes.first { $0.id == id } ?? heroes[id - 1]
        return hero
    }
    
    func loadImageAsync(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error loading image: \(error)")
                completion(nil)
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                completion(nil)
            }
        }.resume()
    }
}




