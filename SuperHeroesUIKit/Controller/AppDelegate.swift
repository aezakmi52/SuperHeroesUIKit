//
//  AppDelegate.swift
//  SuperHeroesUIKit
//
//  Created by Админ on 03.07.2024.
//

import UIKit

@main

// MARK: - AppDelegate

class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Properties
    
    var window: UIWindow?

    // MARK: - Useful
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        let heroes: [HeroModel] = DataDownloadService().load(file: "Hero.json")
        DataService.shared.heroes = heroes
        
        let heroesVC = HeroesViewController(category: .superheroes)
        let villainsVC = VillainsViewController(category: .supervillains)
        
        heroesVC.tabBarItem = UITabBarItem(title: "Superheroes", image: UIImage(named: "superheroes"), tag: 0)
        villainsVC.tabBarItem = UITabBarItem(title: "Supervillains", image: UIImage(named: "supervillains"), tag: 1)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [UINavigationController(rootViewController: heroesVC), UINavigationController(rootViewController: villainsVC)]
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        
        return true
    }
}

