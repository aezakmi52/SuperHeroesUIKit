//
//  HeroTableViewCell.swift
//  SuperHeroesUIKit
//
//  Created by Админ on 28.07.2024.
//

import UIKit


class HeroTableViewCell: UITableViewCell {
    
    let heroImage = UIImageView()
    let name = UILabel()
    let statsStackView = UIStackView()
    let favoriteButton = UIButton(type: .system)
    
    var isFavorite: Bool = false {
        didSet {
            let starImage = isFavorite ? UIImage(named: "star.fill") : UIImage(named: "star")
            favoriteButton.setImage(starImage, for: .normal)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        heroImage.translatesAutoresizingMaskIntoConstraints = false
        name.translatesAutoresizingMaskIntoConstraints = false
        statsStackView.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(heroImage)
        contentView.addSubview(name)
        contentView.addSubview(statsStackView)
        contentView.addSubview(favoriteButton)
        
        NSLayoutConstraint.activate([            
            heroImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            heroImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            heroImage.widthAnchor.constraint(equalToConstant: 164),
            heroImage.heightAnchor.constraint(equalToConstant: 164),
            
            name.leadingAnchor.constraint(equalTo: favoriteButton.trailingAnchor, constant: 8),
            name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            name.centerYAnchor.constraint(equalTo: favoriteButton.centerYAnchor),

            
            statsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            statsStackView.topAnchor.constraint(equalTo: name.bottomAnchor, constant:16),
            
            favoriteButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            favoriteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16)
        ])
        
        statsStackView.axis = .vertical
        statsStackView.spacing = 8
        
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        
        name.font = UIFont.boldSystemFont(ofSize: 22)
        name.textColor = .white
        favoriteButton.tintColor = UIColor(red: 255/255, green: 159/255, blue: 10/255, alpha: 1)
        favoriteButton.setTitle("", for: .normal)
        favoriteButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    func configure(with hero: HeroModel) {
        name.text = hero.name.capitalized
        
        let url = URL(string: hero.imageURL)
        if let data = try? Data(contentsOf: url!) {
            heroImage.image = UIImage(data: data)
        }
        
        isFavorite = hero.isFavorite
        
        statsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let stats = [
            "INT": hero.stats.intelligence,
            "POW": hero.stats.power,
            "SPD": hero.stats.speed,
            "END": hero.stats.endurance,
            "REA": hero.stats.reaction,
            "PRO": hero.stats.protection
        ]
        
        for (stat, value) in stats {
            let label = UILabel()
            label.text = "\(value) \(stat)"
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
            statsStackView.addArrangedSubview(label)
        }
        
        contentView.backgroundColor = hero.color.outputColor
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
    }
}
