//
//  ListCollectionViewController.swift
//  ListMe
//
//  Created by Javra Software on 10/3/20.
//

import UIKit
import SwiftUI
import Combine

class ListCollectionViewController: UICollectionViewController {
    
    enum Section {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section,ListItem>!
    
    var listViewModel: ListViewModel = ListViewModel()
    
    var subscription: Set<AnyCancellable> = []
    
    init() {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80))
        
        let items = NSCollectionLayoutItem(layoutSize: itemSize)
        
        items.contentInsets = .init(top: 10, leading: 35, bottom: 0, trailing: 35)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80))
        
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
        
        collectionView.backgroundColor = UIColor(Color(#colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)))
        
        collectionView.register(Cell.self, forCellWithReuseIdentifier: Cell.reuseIdentifier)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.title = "All Lists"
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addList)),
        ]
        
        configureDataSource()
        
        
        
        
    }
    
    func configureDataSource() {
        
        dataSource = .init(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
                fatalError()
            }
            
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, ListItem>()
        
        snapshot.appendSections([.main])
        
        snapshot.appendItems(listViewModel.listItems)
        
        dataSource.apply(snapshot)
    }
}

extension ListCollectionViewController {
    
    @objc func addList() {
        
        let listForm = ListForm {
            self.dismiss(animated: true, completion: nil)
        }
        
        let controller = UIHostingController(rootView: listForm)
        
        controller.modalPresentationStyle = .popover
        
        listForm.listViewModel.$listItems.sink { [unowned self] (items) in
            if !items.isEmpty {
                updateDatasource(item: items)
            }
        }.store(in: &subscription)
        
        present(controller, animated: true, completion: nil)
    }
    
    func updateDatasource(item: [ListItem]) {
        var snapshot = dataSource.snapshot()
        snapshot.appendItems(item)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

class Cell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 18
        clipsToBounds = true
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
