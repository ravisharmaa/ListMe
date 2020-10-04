//
//  CartCell.swift
//  ListMe
//
//  Created by Javra Software on 10/4/20.
//

import Foundation
import UIKit

class CartCell: UICollectionViewCell {
    
    //MARK:- Moved this view to swift ui but might be needed so kept it here.
    
    /*
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
        label.font = UIFont.systemFont(ofSize: 12)
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .black
        backgroundView.layer.cornerRadius = backgroundView.frame.height / 2
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        backgroundView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        backgroundView.addSubview(label)
        
        label.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        
        label.text = "12"
        return label
    }()
    
    fileprivate lazy var rightArrow: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
     
     */
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 18
        clipsToBounds = true
        backgroundColor = .clear
        
        /*
        
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


        let overAllStackView = UIStackView(arrangedSubviews: [
            stackView, itemAndImageStackView
        ])

        addSubview(overAllStackView)

        overAllStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            overAllStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            overAllStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant:20),
            overAllStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
            overAllStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -15)
        ])

        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = .init(width: 1, height: 4)
        layer.shadowRadius = 5
        layer.masksToBounds = false
        
        */
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
