//
//  BaseCollectionView.swift
//  ZalandoAPPDemo
//
//  Created by Umut SERIFLER on 13/01/2021.
//

import UIKit

class BaseCollectionView: UICollectionView {

    init(_ frame: CGRect = .zero, _ layout: UICollectionViewLayout = UICollectionViewLayout(), cellArray: [UICollectionViewCell.Type]) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        super.init(frame: frame, collectionViewLayout: layout)
        self.backgroundColor = .white
        cellArray.forEach { register($0, forCellWithReuseIdentifier: $0.identifier)}
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

}
