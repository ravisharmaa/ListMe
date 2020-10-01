//
//  ViewController.swift
//  ListMe
//
//  Created by Ravi Bastola on 9/22/20.
//

import UIKit
import Combine
import SwiftUI

class CategoriesViewController: UITableViewController {
    
    var subscription: Set<AnyCancellable> = []
    
    enum Section {
        case main
    }
    
    var dataSource: DataSource!
    
    let categoryViewModel: CategoryViewModel = CategoryViewModel()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.title = "Categories"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItems))
        
        tableView.delegate = self
        
        tableView.showsVerticalScrollIndicator = false
        
        refreshControl = UIRefreshControl()
        
        refreshControl?.attributedTitle = NSAttributedString(string: "Refresh")
        
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        configureDataSource()
        categoryViewModel.all()
        
        categoryViewModel.$categories.sink { [unowned self] (categories) in
            showLoadingView()
            updateDatasource(with: categories)
            dismissLoadingView()
        }.store(in: &subscription)
    }
    
    func updateDatasource(with: [Category], animated: Bool = true) {
        var snapshot = dataSource.snapshot()
        snapshot.deleteAllItems()
        snapshot.appendSections([.main])
        snapshot.appendItems(with)
        dataSource.apply(snapshot, animatingDifferences: animated)
    }
    
    
    func configureDataSource() {
        
        dataSource = .init(tableView: tableView, cellProvider: { (tableView, indexPath, item) -> UITableViewCell? in
            
            let cell = UITableViewCell()
            cell.textLabel?.text = item.name
            
            return cell
        })
    }
    
    func configureSnapshot() {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Category>()
        snapshot.appendSections([.main])
        snapshot.appendItems([])
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        guard let selectedItem = dataSource.itemIdentifier(for: indexPath) else {
            return nil
        }
        
        let action = UIContextualAction(style: .destructive, title: "Delete", handler: { [unowned self] (action, view, completionHandler) in
            
            categoryViewModel.delete(category: selectedItem)
            
            var snapshot = dataSource.snapshot()
            
            snapshot.deleteItems([selectedItem])
            
            dataSource.apply(snapshot, animatingDifferences: true)
            
            completionHandler(true)
        })
        
        let editAction = UIContextualAction(style: .normal, title: "Edit", handler: { [unowned self] (action, view, completionHandler) in
            
            let categoryForm = CategoryForm(closeModal: {
                self.dismiss(animated: true, completion: nil)
            }, category: selectedItem)
            
            let controller = UIHostingController(rootView: categoryForm)
            
            categoryForm.categoryViewModel.$categories.sink { (_) in
                //
            } receiveValue: { (category) in
                if !category.isEmpty {
                    var snapshot = dataSource.snapshot()
                    snapshot.deleteItems([selectedItem])
                    snapshot.appendItems(category)
                    snapshot.reloadSections([.main])
                    dataSource.apply(snapshot, animatingDifferences: true)
                }
            }.store(in: &subscription)
            
            present(controller, animated: true, completion: nil)
            
            completionHandler(true)
        })
        
        editAction.backgroundColor = .systemBlue
        
        let configuration = UISwipeActionsConfiguration(actions: [action, editAction])
        
        return configuration
    }
}

extension CategoriesViewController {
    
    class DataSource: UITableViewDiffableDataSource<Section, Category> {
        
        override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
        }
    }
}


extension CategoriesViewController {
    
    @objc func addItems() {
        let form = CategoryForm(closeModal: {
            self.dismiss(animated: true, completion: nil)
        }, category: nil)
        
        let controller = UIHostingController(rootView: form)
        
        controller.modalPresentationStyle = .popover
        
        form.categoryViewModel.$categories.sink { [unowned self] (category) in
            
            if !category.isEmpty {
                var snapshot = dataSource.snapshot()
                
                snapshot.appendItems(category)
                
                snapshot.reloadSections([.main])
                
                dataSource.apply(snapshot, animatingDifferences: true)
            }
        }.store(in: &subscription)
        
        present(controller, animated: true, completion: nil)
    }
}


extension CategoriesViewController {
    
    //MARK:- Complete Update which is pending
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let category = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        
        navigationController?.pushViewController(ProductListViewController(category: category), animated: true)
    }
    
    @objc func refresh() {
        refreshControl?.beginRefreshing()
        categoryViewModel.all()
        
        categoryViewModel.$categories.sink { [unowned self] (categories) in
            updateDatasource(with: categories, animated: false)
            refreshControl?.endRefreshing()
        }.store(in: &subscription)
    }
}
