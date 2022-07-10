//
//  ReusableView.swift
//  Icon
//
//  Created by Stephen Sowole on 7/21/20.
//  Copyright © 2020 Icon Inc. All rights reserved.
//

import UIKit

extension UITableViewCell: ReusableView { }
extension UITableViewHeaderFooterView: ReusableView { }
extension UICollectionViewCell: ReusableView { }


public extension UITableView {

    final func register<T: UITableViewCell>(_ : T.Type) {
        self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }

    final func register<T: UITableViewHeaderFooterView>(_ : T.Type) {
        self.register(T.self, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }

    final func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            assertionFailure("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
            return T()
        }
        return cell
    }

    final func dequeueReusableHeader<T: UITableViewHeaderFooterView>() -> T {
        guard let header = dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T else {
            assertionFailure("Could not dequeue header with identifier: \(T.reuseIdentifier)")
            return T()
        }
        return header
    }
}

extension UICollectionView {

    final func register<T: UICollectionViewCell>(_ : T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    final func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            assertionFailure("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
            return T()
        }
        return cell
    }
}

public protocol ReusableView: AnyObject {
    static var reuseIdentifier: String { get }
}

public extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
