//
//  VillainsViewController.swift
//  SuperHeroesUIKit
//
//  Created by Админ on 28.07.2024.
//

import UIKit

class VillainsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView = UITableView()
    var heroes: [HeroModel] = []
    var displayHeroes: [HeroModel] = []
    var showFavoritesOnly = false {
        didSet {
            displayHeroes = showFavoritesOnly ? heroes.filter { $0.isFavorite } : heroes
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Superheroes"
        view.backgroundColor = .white
        
        setupTableView()
        setupFavoriteFilterButton()
        loadHeroes()
    }
    
    func setupTableView() {
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HeroTableViewCell.self, forCellReuseIdentifier: "HeroCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = .black
        view.addSubview(tableView)
    }
    
    func setupFavoriteFilterButton() {
        let favoriteFilterButton = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(toggleFavoriteFilter))
        navigationItem.rightBarButtonItem = favoriteFilterButton
    }
    
    @objc func toggleFavoriteFilter() {
        showFavoritesOnly.toggle()
        let image = showFavoritesOnly ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        navigationItem.rightBarButtonItem?.image = image
    }
    
    func loadHeroes() {
        if let path = Bundle.main.path(forResource: "Hero", ofType: "json") {
            let url = URL(fileURLWithPath: path)
            do {
                let data = try Data(contentsOf: url)
                heroes = try JSONDecoder().decode([HeroModel].self, from: data).filter { $0.category.rawValue == "supervillains" }
                displayHeroes = heroes
                tableView.reloadData()
            } catch {
                print("Error loading heroes: \(error)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayHeroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeroCell", for: indexPath) as! HeroTableViewCell
        cell.configure(with: displayHeroes[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let hero = displayHeroes[indexPath.row]
        let detailVC = DetailViewController()
        detailVC.hero = hero
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
