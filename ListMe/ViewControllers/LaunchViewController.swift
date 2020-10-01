//
//  LaunchViewController.swift
//  ListMe
//
//  Created by Javra Software on 10/1/20.
//

import UIKit
import SwiftUI

class LaunchViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
    }
    
    fileprivate func configureViewControllers() {
        
        let registrationController = UIHostingController(rootView: UserRegistrationForm())
        
        registrationController.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 0)
        
        let categoriesController = UINavigationController(rootViewController: CategoriesViewController())
        
        categoriesController.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 1)
        
        let searchController = UIHostingController(rootView: SearchView(isModalClosed: nil))
        
        searchController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 2)
        
        viewControllers = [categoriesController, registrationController, searchController]
        
        tabBarController?.selectedIndex = 0
        
    }
}
