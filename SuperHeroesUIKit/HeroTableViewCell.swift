//
//  HeroTableViewCell.swift
//  SuperHeroesUIKit
//
//  Created by Админ on 28.07.2024.
//

import UIKit


class HeroTableViewCell: UITableViewCell {
    
    var hero: HeroModel! {
        didSet {
            updateUI()
        }
    }
    
    let dataService = DataService.shared
    
    let customContentView = UIView()
    let heroImage = UIImageView()
    let name = UILabel()
    let statsStackView = UIStackView()
    let valueStackView = UIStackView()
    let favoriteButton = UIButton()
    
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
        valueStackView.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        customContentView.translatesAutoresizingMaskIntoConstraints = false
        
        customContentView.addSubview(heroImage)
        customContentView.addSubview(name)
        customContentView.addSubview(statsStackView)
        customContentView.addSubview(valueStackView)
        customContentView.addSubview(favoriteButton)
        contentView.addSubview(customContentView)
        
        NSLayoutConstraint.activate([            
            customContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            customContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            customContentView.heightAnchor.constraint(equalToConstant: 200),
            
            heroImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            heroImage.centerYAnchor.constraint(equalTo: customContentView.centerYAnchor),
            heroImage.widthAnchor.constraint(equalToConstant: 164),
            heroImage.heightAnchor.constraint(equalToConstant: 164),
            
            name.leadingAnchor.constraint(equalTo: favoriteButton.trailingAnchor, constant: 8),
            name.topAnchor.constraint(equalTo: customContentView.topAnchor, constant: 16),
            name.centerYAnchor.constraint(equalTo: favoriteButton.centerYAnchor),

            valueStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            valueStackView.topAnchor.constraint(equalTo: name.bottomAnchor, constant:16),
            
            statsStackView.leadingAnchor.constraint(equalTo: valueStackView.trailingAnchor, constant: 8),
            statsStackView.topAnchor.constraint(equalTo: name.bottomAnchor, constant:16),
            
            favoriteButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            favoriteButton.topAnchor.constraint(equalTo: customContentView.topAnchor, constant: 16)
        ])
        valueStackView.axis = .vertical
        valueStackView.spacing = 2
        
        statsStackView.axis = .vertical
        statsStackView.spacing = 2
        
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        
        name.font = UIFont.boldSystemFont(ofSize: 22)
        name.textColor = .white
        favoriteButton.tintColor = UIColor(red: 255/255, green: 159/255, blue: 10/255, alpha: 1)
        favoriteButton.setTitle("", for: .normal)
        favoriteButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        favoriteButton.addTarget(self, action: #selector(toggleFavorite), for: .touchUpInside)
    }
    
    func updateUI() {
        favoriteButton.setImage(hero.isFavorite ? UIImage(named: "star.fill") : UIImage(named: "star"), for: .normal)
    }
    
    @objc func toggleFavorite() {
        guard let hero = hero else { return }
        dataService.changeFavorite(id: hero.id, isFavorite: !hero.isFavorite)
        updateUI()
        if let tableView = superview as? UITableView, let indexPath = tableView.indexPath(for: self) {
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
    }
    
    func configure(with hero: HeroModel) {
        name.text = hero.name.capitalized
        
        let url = URL(string: hero.imageURL)
        if let data = try? Data(contentsOf: url!) {
            heroImage.image = UIImage(data: data)
        }
        
        statsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        valueStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let stats = [
            "INT": hero.stats.intelligence,
            "POW": hero.stats.power,
            "SPD": hero.stats.speed,
            "END": hero.stats.endurance,
            "REA": hero.stats.reaction,
            "PRO": hero.stats.protection
        ]
        
        for (value) in stats.values {
            let label = UILabel()
            label.text = "\(value)"
            label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
            valueStackView.addArrangedSubview(label)
        }
        
        for (stat) in stats.keys{
            let label = UILabel()
            label.text = "\(stat)"
            label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.38)
            label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
            statsStackView.addArrangedSubview(label)
        }
        
        customContentView.backgroundColor = hero.color.outputColor
        customContentView.layer.cornerRadius = 24
        customContentView.layer.masksToBounds = true
    }
}
