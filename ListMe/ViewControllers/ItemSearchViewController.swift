//
//  ItemSearchViewController.swift
//  ListMe
//
//  Created by Ravi Bastola on 9/23/20.
//

import UIKit

class ItemSearchViewController: UIViewController {
    
    
    fileprivate lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchBar.placeholder = "Search News, For ex: Apple"
        controller.obscuresBackgroundDuringPresentation = false
        controller.isActive = true
        controller.searchBar.sizeToFit()
        return controller
    }()
    
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.prefersLargeTitles = false
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(close))
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        view.addSubview(tableView)
        
        
        
        navigationItem.searchController = searchController
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchController.isActive = true
    }
    
}

extension ItemSearchViewController {
    
    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
}
