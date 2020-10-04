//
//  ListCollectionViewController.swift
//  ListMe
//
//  Created by Javra Software on 10/3/20.
//

import UIKit
import SwiftUI
import Combine

class CartViewController: UICollectionViewController {
    
    enum Section {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section,ListItem>!
    
    var listViewModel: ListViewModel = ListViewModel()
    
    var subscription: Set<AnyCancellable> = []
    
    init() {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
        
        let items = NSCollectionLayoutItem(layoutSize: itemSize)
        
        items.contentInsets = .init(top: 10, leading: 35, bottom: 0, trailing: 35)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
        
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

extension CartViewController {
    
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
    
    fileprivate lazy var name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hello world"
        label.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        return label
    }()
    
    fileprivate lazy var createdDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "Hello world"
        return label
    }()
    
    fileprivate lazy var toSupplier: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "Hello world"
        return label
    }()
    
    fileprivate lazy var forStore: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "Hello world"
        return label
    }()
    
    fileprivate lazy var itemCount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .heavy)
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .lightGray
        backgroundView.layer.cornerRadius = backgroundView.frame.height / 2
        
        backgroundView.addSubview(label)
        
        label.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        
        label.text = "Hello world"
        return label
    }()
    
    fileprivate lazy var rightArrow: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 18
        clipsToBounds = true
        backgroundColor = .systemBackground
        
        let itemAndImageStackView = UIStackView(arrangedSubviews: [
           UIView(), itemCount, rightArrow
        ])
        
        itemAndImageStackView.spacing = 5
        itemAndImageStackView.axis = .horizontal
        itemAndImageStackView.alignment = .center
        
       
        
        let horizontalStack = UIStackView(arrangedSubviews: [
            toSupplier, forStore
        ])
        
        horizontalStack.setCustomSpacing(10, after: toSupplier)
        
        let stackView = UIStackView(arrangedSubviews: [
            name, createdDate, UIView(), horizontalStack
        ])
        
        stackView.setCustomSpacing(5, after: name)
        
        stackView.axis = .vertical
        
        
       // addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.isLayoutMarginsRelativeArrangement = true
        
        stackView.layoutMargins = .init(top: 10, left: 20, bottom: 0, right: 10)
        
        
        
        let overAllStackView = UIStackView(arrangedSubviews: [
            stackView, itemAndImageStackView
        ])
        
        addSubview(overAllStackView)
        
        overAllStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            overAllStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            overAllStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            overAllStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
            overAllStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -15)
        ])
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
