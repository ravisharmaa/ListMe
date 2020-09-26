//
//  ListProductsViewController.swift
//  ListMe
//
//  Created by Ravi Bastola on 9/23/20.
//

import UIKit
import Combine

class ProductListViewController: UIViewController {
    
    let category: Category
    
    var subscription: Set<AnyCancellable> = []
    
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
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Product>!
    
    init(category: Category) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        let path = ApiConstants.ProductPath.description + "/\(category.name ?? "")"
        
        NetworkManager.shared.sendRequest(to: path, model: Products.self)
            .receive(on: RunLoop.main)
            .catch { (error) -> AnyPublisher<Products, Never> in
                return Just([Product.placeholder]).eraseToAnyPublisher()
            }.sink { (_) in
                //
            } receiveValue: { (products) in
                print(products)
            }.store(in: &subscription)
        
        //configureDataSource()
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
        
        
        
        //        dataSource = .init(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
        //
        //            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        //
        //            return cell
        //        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Product>()
        
        snapshot.appendSections([.recent])
        
        snapshot.appendItems([])
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension ProductListViewController {
    
    @objc func addSection() {
        
        //items.insert(.init(name: "Cofeee"), at: 0)
        
        var snapshot = dataSource.snapshot()
        
        snapshot.deleteItems([])
        
        snapshot.appendItems([])
        
        snapshot.reloadSections([.recent])
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}


extension ProductListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let item = dataSource.itemIdentifier(for: indexPath) else {
            return
        }  
        //navigationController?.pushViewController(ItemDetailsViewController(item: item), animated: true)
    }
}
