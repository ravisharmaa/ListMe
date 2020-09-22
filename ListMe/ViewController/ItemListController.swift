//
//  ItemListController.swift
//  ListMe
//
//  Created by Javra Software on 9/22/20.
//

import UIKit
import SwiftUI

class ItemListController: UITableViewController {
    
    var category: ItemCategory
    
    var dataSource: DataSource!
    
    enum Section {
        case main
    }
    
    init(category: ItemCategory) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = category.name
        
        navigationItem.rightBarButtonItem  = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItems))
        
        configureDataSource()
    }
    
    func configureDataSource() {
        dataSource = .init(tableView: tableView, cellProvider: { (tableView, indexPath, item) -> UITableViewCell? in
            let cell = UITableViewCell()
            cell.textLabel?.text = item.name
            
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        
        snapshot.appendSections([.main])
        
        snapshot.appendItems(category.items ?? [])
        
        dataSource.apply(snapshot)
    }
    
}

extension ItemListController {
    
    class DataSource: UITableViewDiffableDataSource<Section, Item> {
        override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
        }
    }
}

extension ItemListController {
    
    @objc func addItems() {
        let controler = UIHostingController(rootView: ItemForm())
        present(controler, animated: true, completion: nil)
    }
}

extension ItemListController {
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        guard let selectedItem = dataSource.itemIdentifier(for: indexPath) else {
            return nil
        }
        
        let action = UIContextualAction(style: .destructive, title: "Delete",
                                        handler: { [unowned self] (action, view, completionHandler) in
                                            
//                                            let removedItem = self.categories.filter { (item) -> Bool in
//                                                return selectedItem.name == item.name
//                                            }
//
//
//
//                                            var snapshot = dataSource.snapshot()
//                                            snapshot.deleteItems(removedItem)
//
//                                            dataSource.apply(snapshot, animatingDifferences: true)
                                            
                                            completionHandler(true)
                                        })
        
        let editAction = UIContextualAction(style: .normal, title: "Edit",
                                            handler: { [unowned self] (action, view, completionHandler) in
                                                
                                                
                                                
//                                                configureEditAction(item: selectedItem)
                                                
                                                
                                                completionHandler(true)
                                            })
        editAction.backgroundColor = .systemBlue
        
        let configuration = UISwipeActionsConfiguration(actions: [action, editAction])
        return configuration
    }
    
    
    
}
