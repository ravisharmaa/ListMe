//
//  ItemDetailsViewController.swift
//  ListMe
//
//  Created by Ravi Bastola on 9/23/20.
//

import UIKit
import SwiftUI
import Combine

class ItemDetailsViewController: UIViewController {
    
    var item: ProductListViewController.Item
    
    var modelObject: BasketViewModel = BasketViewModel()
    
    var subscription: Set<AnyCancellable> = []
    
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
    
    fileprivate var dataSource: UICollectionViewDiffableDataSource<Section, Int>!
    
    
    init(item: ProductListViewController.Item) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.title = item.name
        
        
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
    
    fileprivate func createLayout() -> UICollectionViewCompositionalLayout {
        
        var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        
        config.trailingSwipeActionsConfigurationProvider = .some({ [weak self] (indexPath) -> UISwipeActionsConfiguration? in
            guard let self = self else {return nil }
            
            guard let _ = self.dataSource.itemIdentifier(for: indexPath) else {
                return nil
            }
            
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
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Int>.init { (cell, indexPath, item) in
            
            var content = cell.defaultContentConfiguration()
            
            content.text = item.description
            
            cell.contentConfiguration = content
        }
        
        dataSource = .init(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
            
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        
        snapshot.appendSections([.main])
        
        snapshot.appendItems(Array(0...20))
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}


extension ItemDetailsViewController {
    
    @objc func addItem() {
        
    }
    
    @objc func configureSearch() {
        
        let search = SearchView {
            self.dismiss(animated: true) { [unowned self] in
                modelObject.subject.sink { (itemp) in
                    print("hello")
                }.store(in: &subscription)
            }
        }
        
        let controller = UIHostingController(rootView: search)
        
        controller.modalPresentationStyle  = .popover
        present(controller, animated: true, completion: nil)
    }
}
