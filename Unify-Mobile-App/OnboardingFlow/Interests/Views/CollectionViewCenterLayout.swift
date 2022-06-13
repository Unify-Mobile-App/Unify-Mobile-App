//
//  CollectionViewCenterLayout.swift
//  Unify
//
//  Created by Melvin Asare on 06/10/2021.
//

import UIKit

class CollectionViewCenterLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else {
            return nil
        }

        var rows = [CollectionViewCenterLayoutRow]()
        var currentRowY: CGFloat = -1
        for attribute in attributes {
            if currentRowY != attribute.frame.midY {
                currentRowY = attribute.frame.midY
                rows.append(CollectionViewCenterLayoutRow(spacing: 10))
            }
            rows.last?.add(attribute: attribute)
        }
        rows.forEach { $0.centerLayout(collectionViewWidth: collectionView?.frame.width ?? 0) }
        return rows.flatMap { $0.attributes }
    }
}
