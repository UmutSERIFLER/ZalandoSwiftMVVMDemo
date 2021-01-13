//
//  FavouriteViewController.swift
//  ZalandoAPPDemo
//
//  Created by Umut SERIFLER on 13/01/2021.
//

import UIKit

class FavouriteViewController: UIViewController {

    var favouriteCollectionView: UICollectionView!
    private(set) var productDataSource: ProductDataSource?
    
    init(collectionView: UICollectionView = BaseCollectionView(cellArray: [ProductCollectionViewCell.self])) {
        super.init(nibName: nil, bundle: nil)
        self.favouriteCollectionView = collectionView
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(favouriteCollectionView)
        favouriteCollectionView.translatesAutoresizingMaskIntoConstraints = false
        favouriteCollectionView.frame = view.frame
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.productDataSource = self.setUpDataSource()
    }
    
}
//// MARK: - Private Methods
fileprivate extension FavouriteViewController {
    func setUpDataSource() -> ProductDataSource? {
        let dataSource = ProductDataSource(collectionView: self.favouriteCollectionView, array: [FavouriteProducts().getProducts()], cellConfig: [CellConfigModel(cellHeight: 300)])
        dataSource.collectionItemSelectionHandler = { [weak self] indexPath in
            if let productCell: ProductCollectionViewCell = self?.favouriteCollectionView.cellForItem(at: indexPath) as? ProductCollectionViewCell, let product = productCell.product {
                DispatchQueue.main.async {
                    self?.navigationController?.pushViewController(ProductDetailViewController(product: product), animated: true)
                    
                }
            }
        }
        return dataSource
    }
}
