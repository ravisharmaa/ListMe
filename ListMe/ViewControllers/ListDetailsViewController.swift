//
//  ItemDetailsViewController.swift
//  ListMe
//
//  Created by Ravi Bastola on 9/23/20.
//

import UIKit
import SwiftUI
import Combine

class ListDetailsViewController: UIViewController {
    
    //let addedItems = BasketViewModel().items
    
    
    fileprivate lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collection.showsVerticalScrollIndicator = false
        
        collection.backgroundColor = .systemBackground
        return collection
    }()
    
    
    enum Section {
        case main
    }
    
    //fileprivate var dataSource: UICollectionViewDiffableDataSource<Section, DummyListFactory>!
    
    
//    init(item: ProductListViewController.Item) {
//        self.item = item
//        super.init(nibName: nil, bundle: nil)
//    }
    
//    required init?(coder: NSCoder) {
//        fatalError()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //navigationItem.title = item.name
        
        
        navigationItem.rightBarButtonItems  = [
            UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem)),
            UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(configureSearch)),
            
        ]
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        configureDataSource()
        
        configureSearch()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.backBarButtonItem?.title = String()
    }
    
    fileprivate func createLayout() -> UICollectionViewCompositionalLayout {
        
        var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        
        config.trailingSwipeActionsConfigurationProvider = .some({ [weak self] (indexPath) -> UISwipeActionsConfiguration? in
            guard let self = self else {return nil }
            
//            guard let _ = self.dataSource.itemIdentifier(for: indexPath) else {
//                return nil
//            }
            
            var action: [UIContextualAction] = [UIContextualAction]()
            
            let leadingSwipeAction = UIContextualAction(style: .normal, title: "Edit") { (_, _, completion) in
               
                completion(true)
            }
            
            leadingSwipeAction.backgroundColor = .systemBlue
            
            let secondLeadingSwipe = UIContextualAction(style: .destructive, title: "Delete") { (_, _, completion) in
               
                completion(true)
            }
            
            action.append(secondLeadingSwipe)
            
            action.append(leadingSwipeAction)
            
            return UISwipeActionsConfiguration(actions: action)
            
            
        })
        
        return .list(using: config)
    }
    
    
    func configureDataSource() {
//        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, DummyListFactory>.init { (cell, indexPath, item) in
//
//            var content = cell.defaultContentConfiguration()
//
//            content.text = item.name
//
//            cell.contentConfiguration = content
//        }
//
//        dataSource = .init(collectionView: collectionView, cellProvider: { (collectionView, indexPath, listItem) -> UICollectionViewCell? in
//            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: listItem)
//
//            return cell
//        })
//
//        var snapshot = NSDiffableDataSourceSnapshot<Section, DummyListFactory>()
//
//        snapshot.appendSections([.main])
//
//        snapshot.appendItems(addedItems)
//
//        dataSource.apply(snapshot, animatingDifferences: true)
    }
}


extension ListDetailsViewController {
    
    @objc func addItem() {
        
    }
    
    @objc func configureSearch() {
        
//        let search = SearchView(isSearchShown: .constant(false), viewModel: .init()) 
//        
//        let controller = UIHostingController(rootView: search)
//        
//        controller.modalPresentationStyle  = .popover
//        
//        present(controller, animated: true, completion: nil)
    }
    
//    func updateSnapshotwith(newItem: [DummyListFactory]) {
//        
//        var snapshot = dataSource.snapshot()
//        
//        if !newItem.isEmpty {
//            
//            snapshot.deleteAllItems()
//            
//            snapshot.appendSections([.main])
//            
//            snapshot.appendItems(newItem)
//            
//            snapshot.reloadSections([.main])
//            
//            dataSource.apply(snapshot, animatingDifferences: false)
//        }
//    }
}
