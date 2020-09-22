//
//  ViewController.swift
//  ListMe
//
//  Created by Ravi Bastola on 9/22/20.
//

import UIKit

class CategoriesViewController: UITableViewController {
    
    
    var categories: [ItemCategory] = [
        ItemCategory(name: "Chips", items: [
            
            Item(name: "Doritos",
                 barCode: .init(type: "UUID", number: 123456),
                 image: "Some Random Image",
                 flavour: "Butter Ranc",
                 weight: "12 oz",
                 unit: "1",
                 supplier: nil),
            Item(name: "Lays",
                 barCode: .init(type: "UUID", number: 123456),
                 image: "Some Random Image",
                 flavour: "Regular",
                 weight: "12 oz",
                 unit: "10",
                 supplier: nil)
        ]),
        ItemCategory(name: "Energy Drinks"),
        ItemCategory(name: "Soda"),
        ItemCategory(name: "Bakery")
    ]
    
    enum Section {
        case main
    }
    
    var dataSource: DataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.title = "Categories"
        
        navigationItem.rightBarButtonItem  = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItems))
        
        tableView.delegate = self
        
        configureDataSource()
    }
    
    
    func configureDataSource() {
        dataSource = .init(tableView: tableView, cellProvider: { (tableView, indexPath, item) -> UITableViewCell? in
            let cell = UITableViewCell()
            cell.textLabel?.text = item.name
            
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, ItemCategory>()
        
        snapshot.appendSections([.main])
        
        snapshot.appendItems(categories)
        
        dataSource.apply(snapshot)
    }
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        guard let selectedItem = dataSource.itemIdentifier(for: indexPath) else {
            return nil
        }
        
        let action = UIContextualAction(style: .destructive, title: "Delete",
                                        handler: { [unowned self] (action, view, completionHandler) in
                                            
                                            let removedItem = self.categories.filter { (item) -> Bool in
                                                return selectedItem.name == item.name
                                            }
                                            
                                            
                                            
                                            var snapshot = dataSource.snapshot()
                                            snapshot.deleteItems(removedItem)
                                            
                                            dataSource.apply(snapshot, animatingDifferences: true)
                                            
                                            completionHandler(true)
                                        })
        
        let editAction = UIContextualAction(style: .normal, title: "Edit",
                                            handler: { [unowned self] (action, view, completionHandler) in
                                                
                                                
                                                
                                                configureEditAction(item: selectedItem)
                                                
                                                
                                                completionHandler(true)
                                            })
        editAction.backgroundColor = .systemBlue
        
        let configuration = UISwipeActionsConfiguration(actions: [action, editAction])
        return configuration
    }
    
    
    
}

extension CategoriesViewController {
    
    class DataSource: UITableViewDiffableDataSource<Section, ItemCategory> {
        override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
        }
    }
}


extension CategoriesViewController {
    
    @objc func addItems() {
        
        let alertController = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Category Name"
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: {[unowned self] alert -> Void in
            let firstTextField = alertController.textFields![0] as UITextField
            guard let text = firstTextField.text else {
                return
            }
            
            let category: ItemCategory = .init(name: text)
            self.categories.append(category)
            
            var snapshot = dataSource.snapshot()
            
            snapshot.appendItems([category])
            snapshot.reloadSections([.main])
            
            dataSource.apply(snapshot, animatingDifferences: true)
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: {
                                            (action : UIAlertAction!) -> Void in })
        
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func configureEditAction(item: ItemCategory) {
        
        let alertController = UIAlertController(title: "Update Name", message: "", preferredStyle: .alert)
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.text = item.name
        }
        
        let updateAction = UIAlertAction(title: "Update", style: .default, handler: {[unowned self] alert -> Void in
            let firstTextField = alertController.textFields![0] as UITextField
            guard let text = firstTextField.text else {
                return
            }
            
            var categoryItem = categories.filter { (category) -> Bool in
                return category.name == item.name
            }.first
            
            categoryItem?.name = text
            
            var snapshot = dataSource.snapshot()
            
            
            
            snapshot.reloadItems([item])
            snapshot.reloadSections([.main])
            
            dataSource.apply(snapshot, animatingDifferences: true)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: {
                                            (action : UIAlertAction!) -> Void in })
        
        
        alertController.addAction(cancelAction)
        alertController.addAction(updateAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}


extension CategoriesViewController {
    
    //MARK:- Complete Update which is pending
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // if there is no item in a category present alert showing no items
        
        guard let category = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        navigationController?.pushViewController(ItemListController(category: category), animated: true)
    }
}
