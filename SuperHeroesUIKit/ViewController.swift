//
//  ViewController.swift
//  SuperHeroesUIKit
//
//  Created by Админ on 03.07.2024.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let tableView = UITableView()
    var heroes = [HeroModel]()
    var displayHero: [HeroModel] {
        return showFavoritesOnly ? heroes.filter { $0.isFavorite } : heroes
    }
    var showFavoritesOnly = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HeroTableViewCell.self, forCellReuseIdentifier: "HeroCell")
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([            
            tableView.topAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Favorites", style: .plain, target: self, action: #selector(toggleFavorites))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 255/255, green: 159/255, blue: 10/255, alpha: 1)
        
        loadHeroes()
    }
    
    @objc private func toggleFavorites() {
        showFavoritesOnly.toggle()
        navigationItem.rightBarButtonItem?.title = showFavoritesOnly ? "All" : "Favorites"
        tableView.reloadData()
    }
    
    private func loadHeroes() {
        guard let url = Bundle.main.url(forResource: "Hero", withExtension: "json") else { return }
        do {
            let data = try Data(contentsOf: url)
            heroes = try JSONDecoder().decode([HeroModel].self, from: data)
            tableView.reloadData()
        } catch {
            print("Error loading heroes: \(error)")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayHero.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeroCell", for: indexPath) as! HeroTableViewCell
        cell.configure(with: displayHero[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let hero = displayHero[indexPath.row]
        let detailVC = DetailViewController()
        detailVC.hero = hero
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

