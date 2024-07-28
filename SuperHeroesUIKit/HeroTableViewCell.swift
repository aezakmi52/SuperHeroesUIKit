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
            let starImage = isFavorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
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
            heroImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            heroImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            heroImage.widthAnchor.constraint(equalToConstant: 60),
            heroImage.heightAnchor.constraint(equalToConstant: 60),
            
            name.leadingAnchor.constraint(equalTo: heroImage.trailingAnchor, constant: 16),
            name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            name.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -16),
            
            statsStackView.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            statsStackView.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 8),
            statsStackView.trailingAnchor.constraint(equalTo: name.trailingAnchor),
            
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            favoriteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        statsStackView.axis = .horizontal
        statsStackView.spacing = 8
    }
    
    func configure(with hero: HeroModel) {
        name.text = hero.name
        heroImage.image = UIImage(named: hero.imageURL)
        isFavorite = hero.isFavorite
        
        statsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let label = UILabel()
        label.text = "INT: \(hero.stats.intelligence)"
        statsStackView.addArrangedSubview(label)
        
    }
}
