//
//  CategoryViewController.swift
//  ZalandoAPPDemo
//
//  Created by Umut SERIFLER on 13/01/2021.
//

import UIKit

class CategoryViewController: UIViewController {

    var categoryViewModel: CategoryViewModel?
    var categoryCollectionView: UICollectionView?
    private(set) var productDataSource: ProductDataSource?
    
    lazy var rightBarButtonItem : UIBarButtonItem = {
        var rightBarButton = UIBarButtonItem(title: "Filter", style: .done, target: self, action: #selector(sortList))
        rightBarButton.tintColor = .orange
        return rightBarButton
    }()
    
    init(viewModel: CategoryViewModel = CategoryViewModel(), collectionView: UICollectionView = BaseCollectionView(cellArray: [ProductCollectionViewCell.self])) {
        super.init(nibName: nil, bundle: nil)
        self.categoryViewModel = viewModel
        self.categoryCollectionView = collectionView
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        guard let collectionView = self.categoryCollectionView else { return }
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.frame = view.frame
        self.initViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.categoryViewModel?.getCategoryProducts()
    }
    
    // Initiliase View Model Actions
    func initViewModel() {
        
        categoryViewModel?.reloadTableViewClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.productDataSource = self?.setUpDataSource()
            }
        }
        
        categoryViewModel?.showAlertClosure = { [weak self] errorMessage in
            guard let errorMessage = errorMessage else { return }
            self?.showAlert(withMessage: errorMessage)
        }
    }
    
    @objc func sortList() {
        DispatchQueue.main.async { [weak self] in
            let filterVC = ChooserPopoverTableViewController { (selectedOption) in
                self?.productDataSource = self?.setUpDataSource(filter: selectedOption)
            }
            filterVC.preferredContentSize = CGSize(width: 150, height: 50)
            let presentationController = ChooserPopoverViewModel.configurePresentation(forController: filterVC)
            let referenceView = self?.rightBarButtonItem.value(forKey: "view") as? UIView
            presentationController.sourceView = referenceView
            presentationController.sourceRect = referenceView?.bounds ?? CGRect(origin: .zero, size: CGSize(width: 50, height: 100))
            presentationController.permittedArrowDirections = [.up]
            self?.present(filterVC, animated: true)
        }
    }

}

class ProductDataSource: CollectionArrayDataSource<Product, ProductCollectionViewCell> {}

//// MARK: - Private Methods
fileprivate extension CategoryViewController {
    func setUpDataSource(filter: String? = nil) -> ProductDataSource? {
        guard let products = categoryViewModel?.getProducts(withFilter: filter), let collectionView = self.categoryCollectionView else {
            return nil
        }
        let dataSource = ProductDataSource(collectionView: collectionView, array: [products], cellConfig: [CellConfigModel(cellHeight: 300)])
        dataSource.collectionItemSelectionFetchHandler = { [weak self] (indexPath, isSelected) in
            if isSelected {
                if let productCell: ProductCollectionViewCell = collectionView.cellForItem(at: indexPath) as? ProductCollectionViewCell, let product = productCell.product {
                    DispatchQueue.main.async {
                        self?.navigationController?.pushViewController(ProductDetailViewController(product: product), animated: true)
                    }
                }
            } else {
                self?.categoryViewModel?.fetchData(indexPath: indexPath)
            }
        }
        return dataSource
    }
}
