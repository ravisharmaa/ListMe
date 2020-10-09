//
//  LaunchViewController.swift
//  ListMe
//
//  Created by Ravi Bastola on 10/1/20.
//

import UIKit
import SwiftUI

class LaunchViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
        UITabBar.appearance().tintColor = .label
        UITabBar.appearance().unselectedItemTintColor = .systemBlue
    }
    
    fileprivate func configureViewControllers() {
        
        let listViewController = UINavigationController(rootViewController: CartViewController())
        
        listViewController.tabBarItem = UITabBarItem(title: "Lists", image: UIImage(systemName: "list.dash"), tag: 3)
        
        let registrationController = UIHostingController(rootView: ProfileView())
        
        registrationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 0)
        
        let categoriesController = UINavigationController(rootViewController: CategoriesViewController())
        
        categoriesController.tabBarItem = UITabBarItem(title: "Categories", image: UIImage(systemName: "app.gift"), tag: 1)
        
        let searchController = UIHostingController(rootView: SearchView(isModalClosed: nil))
        
        searchController.tabBarItem = UITabBarItem(title: "Discover", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        
        viewControllers = [listViewController,categoriesController, searchController, registrationController]
        
        tabBarController?.selectedIndex = 0
        
    }
}
