//
//  ListProductsViewController.swift
//  ListMe
//
//  Created by Ravi Bastola on 9/23/20.
//

import UIKit

class ProductListViewController: UIViewController {
    
    fileprivate lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        collection.backgroundColor = .systemBackground
        collection.delegate = self
        return collection
    }()
    
    
    enum Section {
        case recent
        case completed
    }
    
    struct Item: Identifiable, Hashable {
        let id = UUID()
        
        let name: String
        
    }
    
    var items: [Item] = [
          Item(name: "Sams Club Pickup"),
          Item(name: "AAA Order"),
          Item(name: "VicksBerg Order"),
          Item(name: "RedBull Order")
      ]
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        navigationItem.rightBarButtonItem  = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addSection))
        
        configureDataSource()
    }
    
    fileprivate func createLayout() -> UICollectionViewCompositionalLayout {
        
        var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        
        config.trailingSwipeActionsConfigurationProvider = .some({ [weak self] (indexPath) -> UISwipeActionsConfiguration? in
            guard let self = self else {return nil }
            guard let item = self.dataSource.itemIdentifier(for: indexPath) else {
                return nil
            }
            
            var action: [UIContextualAction] = [UIContextualAction]()
            
            let leadingSwipeAction = UIContextualAction(style: .normal, title: "Edit") { (_, _, completion) in
                print(item.name)
                completion(true)
            }
            
            leadingSwipeAction.backgroundColor = .systemBlue
            
            let secondLeadingSwipe = UIContextualAction(style: .destructive, title: "Delete") { (_, _, completion) in
                print(item.name)
                completion(true)
            }
            
            
           
            
            action.append(secondLeadingSwipe)
            action.append(leadingSwipeAction)
            
            
            return UISwipeActionsConfiguration(actions: action)
            
            
        })
        
        return .list(using: config)
    }
    
    func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Item> { (cell, indexPath, item) in
            
            var content = cell.defaultContentConfiguration()
            
            content.text = item.name
            
            cell.accessories = [.disclosureIndicator()]
            
            cell.contentConfiguration = content
        }
        
        
        
        dataSource = .init(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
            
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        
        snapshot.appendSections([.recent])
        
        snapshot.appendItems(items)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension ProductListViewController {
   
    @objc func addSection() {
        
        items.insert(.init(name: "Cofeee"), at: 0)
        
        var snapshot = dataSource.snapshot()
        
        snapshot.deleteItems(items)
        
        snapshot.appendItems(items)
        
        snapshot.reloadSections([.recent])
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}


extension ProductListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let item = dataSource.itemIdentifier(for: indexPath) else {
            return
        }  
        navigationController?.pushViewController(ItemDetailsViewController(item: item), animated: true)
    }
}
