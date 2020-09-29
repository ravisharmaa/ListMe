//
//  ViewController.swift
//  ListMe
//
//  Created by Ravi Bastola on 9/22/20.
//

import UIKit
import Combine

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
        
        configureDataSource()
        categoryViewModel.fetchCategories()
        categoryViewModel.$categories.sink { [unowned self] (categories) in
            showLoadingView()
            updateDatasource(with: categories)
            dismissLoadingView()
        }.store(in: &subscription)
    }
    
    func updateDatasource(with: [Category]) {
        var snapshot = dataSource.snapshot()
        snapshot.deleteAllItems()
        snapshot.appendSections([.main])
        snapshot.appendItems(with)
        dataSource.apply(snapshot)
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
        
        dataSource.apply(snapshot)
    }
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        guard let selectedItem = dataSource.itemIdentifier(for: indexPath) else {
            return nil
        }
        
        let action = UIContextualAction(style: .destructive, title: "Delete", handler: { [unowned self] (action, view, completionHandler) in
            
            categoryViewModel.deleteCategory(category: selectedItem)
            
            var snapshot = dataSource.snapshot()
            
            snapshot.deleteItems([selectedItem])
            
            dataSource.apply(snapshot, animatingDifferences: true)
            
            completionHandler(true)
        })
        
        let editAction = UIContextualAction(style: .normal, title: "Edit", handler: { [unowned self] (action, view, completionHandler) in
            configureEditAction(item: selectedItem)
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
        
        let alertController = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Category Name"
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: {[unowned self] alert -> Void in
            
            let firstTextField = alertController.textFields![0] as UITextField
            
            guard let _ = firstTextField.text else {
                return
            }
            
            // let category: Category = .init(name: text)
            
            //self.categories.append(category)
            
            var snapshot = dataSource.snapshot()
            
            //snapshot.appendItems([category])
            
            snapshot.reloadSections([.main])
            
            dataSource.apply(snapshot, animatingDifferences: true)
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        
        alertController.addAction(cancelAction)
        
        alertController.addAction(saveAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func configureEditAction(item: Category) {
        
        let alertController = UIAlertController(title: "Update Name", message: "", preferredStyle: .alert)
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.text = item.name
        }
        
        let updateAction = UIAlertAction(title: "Update", style: .default, handler: {[unowned self] alert -> Void in
            
            let firstTextField = alertController.textFields![0] as UITextField
            
            guard let _ = firstTextField.text else {
                return
            }
            
            //            let category = categories.map { (itemCateogry) -> Category in
            //
            //                var _ = itemCateogry
            //
            //                if itemCateogry.name == item.name {
            //                    //                    cat.name = text
            //                }
            //
            //                return itemCateogry
            //            }
            
            //print(category)
            
            //            var categoryItem = categories.filter { (category) -> Bool in
            //                return category.name == item.name
            //            }.first ?? nil
            //
            //            categoryItem?.name = text
            
            var snapshot = dataSource.snapshot()
            
            snapshot.deleteAllItems()
            
            snapshot.appendSections([.main])
            
            // snapshot.appendItems(category)
            
            dataSource.apply(snapshot, animatingDifferences: true)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        
        alertController.addAction(cancelAction)
        alertController.addAction(updateAction)
        
        self.present(alertController, animated: true, completion: nil)
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
}
