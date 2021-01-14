//
//  CategoryTableViewController.swift
//  ZalandoAPPDemo
//
//  Created by Umut SERIFLER on 14/01/2021.
//

import UIKit

class CategoryTableViewController: UIViewController {
    
    var categoryTableViewModel: CategoryTableViewModel?
    var categoryTableView: UITableView?
    private(set) var productDataSource: ProductTVDataSource?
    
    init(viewModel: CategoryTableViewModel = CategoryTableViewModel(), tableView: UITableView = BaseTableView(cellArray: [ProductTableViewCell.self])) {
        super.init(nibName: nil, bundle: nil)
        self.categoryTableViewModel = viewModel
        self.categoryTableView = tableView
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let tableView = self.categoryTableView else { return }
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.frame = view.frame
        self.initViewModel()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.categoryTableViewModel?.getCategoryProducts()
    }
    
    // Initiliase View Model Actions
    func initViewModel() {
        categoryTableViewModel?.reloadTableViewClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.productDataSource = self?.setUpDataSource()
            }
        }
        
        categoryTableViewModel?.showAlertClosure = { [weak self] errorMessage in
            guard let errorMessage = errorMessage else { return }
            self?.showAlert(withMessage: errorMessage)
        }
    }
    

}

class ProductTVDataSource: TableArrayDataSource<Product, ProductTableViewCell> {}

//// MARK: - Private Methods
fileprivate extension CategoryTableViewController {
    func setUpDataSource() -> ProductTVDataSource? {
        guard let products = categoryTableViewModel?.getProducts(), let tableView = categoryTableView else {
            return nil
        }
        let dataSource = ProductTVDataSource(tableView: tableView, array: [products], cellConfig: [CellConfigModel(cellHeight: 100)])
        dataSource.tableItemSelectionHandler = { [weak self] indexPath in
            if let productCell: ProductTableViewCell = tableView.cellForRow(at: indexPath) as? ProductTableViewCell, let product = productCell.product {
                DispatchQueue.main.async {
                    self?.navigationController?.pushViewController(ProductDetailViewController(product: product), animated: true)
                }
            }
        }
        return dataSource
    }
}
