//
//  TabBarController.swift
//  SuperHeroesUIKit
//
//  Created by Админ on 04.07.2024.
//

import UIKit

final class TabBarController: UITabBarController {
   
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
    
        tabBar.backgroundColor = .clear
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .gray
        
        let superheroesController = UIViewController()
        let supervillainsController = UIViewController()
        
        let superheroesNavigation = UINavigationController(rootViewController: superheroesController)
        let supervillainsNavigation = UINavigationController(rootViewController: supervillainsController)
        
        superheroesController.tabBarItem = UITabBarItem(title: "Superheroes",
                                                        image: UIImage(named: "superheroes"),
                                                        tag: 0)
        supervillainsController.tabBarItem = UITabBarItem(title: "Supervillains",
                                                          image: UIImage(named: "supervillains"),
                                                          tag: 1)
    
        setViewControllers([superheroesNavigation, supervillainsNavigation], animated: false)
    }
}
