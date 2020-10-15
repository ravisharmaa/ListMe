//
//  ListCollectionViewController.swift
//  ListMe
//
//  Created by Ravi Bastola on 10/3/20.
//

import UIKit
import SwiftUI
import Combine

class CartViewController: UICollectionViewController {
    
    enum Section {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section,CartItem>!
    
    var listViewModel: ListViewModel = ListViewModel()
    
    var subscription: Set<AnyCancellable> = []
    
    init() {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(120))
        
        let items = NSCollectionLayoutItem(layoutSize: itemSize)
        
        items.contentInsets = .init(top: 10, leading: 20, bottom: 5, trailing: 20)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(120))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [items])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(Color(#colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)))
        
        collectionView.backgroundColor = UIColor(Color(#colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9607843137, alpha: 1)))
        
        collectionView.register(CartCell.self, forCellWithReuseIdentifier: CartCell.reuseIdentifier)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.title = "All Lists"
        
        collectionView.delegate = self
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addList)),
        ]
        
        configureDataSource()
    }
    
    func configureDataSource() {
        
        dataSource = .init(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CartCell.reuseIdentifier, for: indexPath) as? CartCell else {
                fatalError()
            }
            
            
            let cartView = CartView(cartItem: item)
            
            let controller = UIHostingController(rootView: cartView)
            
            self.addChild(controller)
            
            cell.addSubview(controller.view)
            
           
            
            controller.view.translatesAutoresizingMaskIntoConstraints = false
            
            controller.view.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
            controller.view.leadingAnchor.constraint(equalTo: cell.leadingAnchor).isActive = true
            controller.view.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
            controller.view.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
            
            
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, CartItem>()
        
        snapshot.appendSections([.main])
        
        snapshot.appendItems(listViewModel.listItems)
        
        dataSource.apply(snapshot)
    }
}

extension CartViewController {
    
    @objc func addList() {
        
        let listForm = ListForm(isModalClosed: {
            self.dismiss(animated: true, completion: nil)
        }, closeList: .constant(false))
        
        let controller = UIHostingController(rootView: listForm)
        
        controller.modalPresentationStyle = .popover
        
        listForm.listViewModel.$listItems.sink { [unowned self] (items) in
            if !items.isEmpty {
                updateDatasource(item: items)
            }
        }.store(in: &subscription)
        
        present(controller, animated: true, completion: nil)
    }
    
    func updateDatasource(item: [CartItem]) {
        var snapshot = dataSource.snapshot()
        snapshot.appendItems(item)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension CartViewController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let _ = dataSource.itemIdentifier(for: indexPath)
        
        navigationController?.pushViewController(ListDetailsViewController(), animated: true)
        
        
    }
}
