//
//  SceneDelegate.swift
//  SuperHeroesUIKit
//
//  Created by Админ on 03.07.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UINavigationController(rootViewController: ViewController())
        window.makeKeyAndVisible()
        
        self.window = window
    
        let heroesVC = HeroesViewController()
        let villainsVC = VillainsViewController()
        
        heroesVC.tabBarItem = UITabBarItem(title: "Superheroes", image: UIImage(named: "superheroes"), tag: 0)
        villainsVC.tabBarItem = UITabBarItem(title: "Supervillains", image: UIImage(named: "supervillains"), tag: 1)
        
        let tabBarController = UITabBarController()
        
        tabBarController.tabBar.tintColor = .white
        tabBarController.tabBar.unselectedItemTintColor = .gray
        tabBarController.tabBar.barTintColor = .clear
        
        
        let appearance = UITabBarAppearance()
        
        appearance.backgroundColor = .black
        
        tabBarController.tabBar.standardAppearance = appearance
        tabBarController.tabBar.scrollEdgeAppearance = appearance
        
        tabBarController.viewControllers = [UINavigationController(rootViewController: heroesVC), UINavigationController(rootViewController: villainsVC)]
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
    
}

