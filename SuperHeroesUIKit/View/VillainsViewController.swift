//
//  VillainsViewController.swift
//  SuperHeroesUIKit
//
//  Created by Админ on 28.07.2024.
//


import UIKit

// MARK: - VillainsViewController

class VillainsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Properties
    
    let category: HeroModel.HeroCategory
    let tableView = UITableView()
    var heroes: [HeroModel] = []
    var displayHeroes: [HeroModel] = []
    var showFavoritesOnly = false {
        didSet {
            displayHeroes = showFavoritesOnly ? heroes.filter { $0.isFavorite } : heroes
            tableView.reloadData()
        }
    }
    
    // MARK: - Initializers
    
    init(category: HeroModel.HeroCategory) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("heroesUpdated"), object: nil)
    }
    
    // MARK: - Setup Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateHeroes), name: Notification.Name("heroesUpdated"), object: nil)

        
        heroes = DataService.shared.heroes.filter {$0.category == category}
        displayHeroes = showFavoritesOnly ? heroes.filter { $0.isFavorite } : heroes
        
        view.backgroundColor = .white
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationItem.backBarButtonItem = backButton
        
        
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.clear]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = .clear
        
        setupTableView()
        setupFavoriteFilterButton()
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
        title = category.rawValue.capitalized
    }
    
    func setupFavoriteFilterButton() {
        let favoriteFilterButton = UIBarButtonItem(image: UIImage(named: "star"), style: .plain, target: self, action: #selector(toggleFavoriteFilter))
        favoriteFilterButton.tintColor = UIColor(red: 255/255, green: 159/255, blue: 10/255, alpha: 1)
        navigationItem.rightBarButtonItem = favoriteFilterButton
    }
    
    // MARK: - Helpers
    
    @objc func updateHeroes() {
        heroes = DataService.shared.heroes.filter {$0.category == category}
        displayHeroes = showFavoritesOnly ? heroes.filter { $0.isFavorite } : heroes
        tableView.reloadData()
    }
     
    // MARK: - Actions
    
    @objc func toggleFavoriteFilter() {
        showFavoritesOnly.toggle()
        let image = showFavoritesOnly ? UIImage(named: "star.fill") : UIImage(named: "star")
        navigationItem.rightBarButtonItem?.image = image
    }
    
    // MARK: - Useful
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayHeroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeroCell", for: indexPath) as! HeroTableViewCell
        cell.configure(with: displayHeroes[indexPath.row])
        cell.selectionStyle = .none
        cell.hero = displayHeroes[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let hero = displayHeroes[indexPath.row]
        let detailVC = DetailViewController()
        detailVC.hero = hero
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
