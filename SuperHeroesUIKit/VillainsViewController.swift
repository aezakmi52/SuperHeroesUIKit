//
//  VillainsViewController.swift
//  SuperHeroesUIKit
//
//  Created by Админ on 28.07.2024.
//


import UIKit

class VillainsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let category: String = HeroModel.HeroCategory.supervillains.rawValue.capitalized
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
        view.backgroundColor = .white
        
        title = category
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.clear]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = .clear
        
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
        tableView.rowHeight = 220
        view.addSubview(tableView)
    }
    
    func setupFavoriteFilterButton() {
        let favoriteFilterButton = UIBarButtonItem(image: UIImage(named: "star"), style: .plain, target: self, action: #selector(toggleFavoriteFilter))
        favoriteFilterButton.tintColor = UIColor(red: 255/255, green: 159/255, blue: 10/255, alpha: 1)
        navigationItem.rightBarButtonItem = favoriteFilterButton
    }
    
    @objc func toggleFavoriteFilter() {
        showFavoritesOnly.toggle()
        let image = showFavoritesOnly ? UIImage(named: "star.fill") : UIImage(named: "star")
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
