//
//  UIView+Ext.swift
//  ListMe
//
//  Created by Ravi Bastola on 9/30/20.
//

import UIKit

extension UIView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
