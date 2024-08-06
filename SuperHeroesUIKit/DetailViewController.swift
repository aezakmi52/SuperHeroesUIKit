//
//  DetailViewController.swift
//  SuperHeroesUIKit
//
//  Created by Админ on 27.07.2024.
//

import UIKit

class DetailViewController: UIViewController {
    
    var hero: HeroModel!
    
    let heroImage = UIImageView()
    let name = UILabel()
    let stats = UILabel()
    let favoriteButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        name.text = hero.name.capitalized
        name.textColor = .white
        stats.text = hero.category.rawValue
        stats.textColor = .white
        
        favoriteButton.setTitle(hero.isFavorite ? "In favorites" : "Add to favorites", for: .normal)
        favoriteButton.setTitleColor(.orange, for: .normal)
        favoriteButton.addTarget(self, action: #selector(toggleFavorite), for: .touchUpInside)
        
        heroImage.translatesAutoresizingMaskIntoConstraints = false
        name.translatesAutoresizingMaskIntoConstraints = false
        stats.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(heroImage)
        view.addSubview(name)
        view.addSubview(stats)
        view.addSubview(favoriteButton)
        
        NSLayoutConstraint.activate([
            heroImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            
            name.topAnchor.constraint(equalTo: heroImage.bottomAnchor, constant: 20),
            name.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            name.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            stats.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 20),
            stats.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stats.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            favoriteButton.topAnchor.constraint(equalTo: stats.bottomAnchor, constant: 20),
            favoriteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func configure(with hero: HeroModel) {
        let url = URL(string: hero.imageURL)
        if let data = try? Data(contentsOf: url!) {
            heroImage.image = UIImage(data: data)
        }
    }
    
    @objc func toggleFavorite() {
        hero.isFavorite.toggle()
        favoriteButton.setTitle(hero.isFavorite ? "In favorites" : "Add to favorites", for: .normal)
    }
}
