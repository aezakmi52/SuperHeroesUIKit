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
    let statsStack = UIStackView()
    let valueStack = UIStackView()
    let favoriteButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [hero.color.outputColor.cgColor, UIColor.black.cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        
        
        view.layer.insertSublayer(gradient, at: 0)
        
        name.text = hero.name.capitalized
        name.textColor = .white
        name.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        
        let statsDict = [
            "INTELLIGENCE": hero.stats.intelligence,
            "POWER": hero.stats.power,
            "SPEED": hero.stats.speed,
            "ENDURANCE": hero.stats.endurance,
            "REACTION": hero.stats.reaction,
            "PROTECTION": hero.stats.protection
        ]
        
        for value in statsDict.values {
            let label = UILabel()
            label.text = "\(value)"
            label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
            label.textColor = .white
            valueStack.addArrangedSubview(label)
        }
        
        for stat in statsDict.keys {
            let label = UILabel()
            label.text = "\(stat)"
            label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
            label.textColor = UIColor(white: 1, alpha: 0.38)
            statsStack.addArrangedSubview(label)
        }
        
        statsStack.axis = .vertical
        statsStack.spacing = 16
        
        valueStack.axis = .vertical
        valueStack.spacing = 16
        
        favoriteButton.setTitle(hero.isFavorite ? "In favorites" : "Add to favorites", for: .normal)
        favoriteButton.setTitleColor(hero.isFavorite ? .black : UIColor(red: 255/255, green: 159/255, blue: 10/255, alpha: 1), for: .normal)
        favoriteButton.backgroundColor = (hero.isFavorite ? UIColor(red: 255/255, green: 159/255, blue: 10/255, alpha: 1) : .black)
        favoriteButton.layer.cornerRadius = 16
        favoriteButton.layer.borderWidth = 2
        favoriteButton.layer.borderColor = CGColor(red: 255/255, green: 159/255, blue: 10/255, alpha: 1)
        favoriteButton.addTarget(self, action: #selector(toggleFavorite), for: .touchUpInside)
        
        let url = URL(string: hero.imageURL)
        if let data = try? Data(contentsOf: url!) {
            heroImage.image = UIImage(data: data)
        }
        
        heroImage.translatesAutoresizingMaskIntoConstraints = false
        name.translatesAutoresizingMaskIntoConstraints = false
        statsStack.translatesAutoresizingMaskIntoConstraints = false
        valueStack.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(heroImage)
        view.addSubview(name)
        view.addSubview(statsStack)
        view.addSubview(valueStack)
        view.addSubview(favoriteButton)
        
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            name.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            heroImage.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 50),
            heroImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            heroImage.widthAnchor.constraint(equalToConstant: 164),
            heroImage.heightAnchor.constraint(equalToConstant: 164),
            
            statsStack.topAnchor.constraint(equalTo: heroImage.bottomAnchor, constant: 40),
            statsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 40),
            
            valueStack.trailingAnchor.constraint(equalTo: statsStack.leadingAnchor, constant: -20),
            valueStack.topAnchor.constraint(equalTo: statsStack.topAnchor),
            
            favoriteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            favoriteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            favoriteButton.widthAnchor.constraint(equalToConstant: view.frame.width - 16),
            favoriteButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }

    @objc func toggleFavorite() {
        hero.isFavorite.toggle()
        favoriteButton.setTitle(hero.isFavorite ? "In favorites" : "Add to favorites", for: .normal)
    }
}
