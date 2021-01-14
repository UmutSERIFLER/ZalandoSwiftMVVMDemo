//
//  ProductDetailViewController.swift
//  ZalandoAPPDemo
//
//  Created by Umut SERIFLER on 13/01/2021.
//

import UIKit

class ProductDetailViewController: UIViewController {

    var product: Product!
    
    init(product: Product) {
        super.init(nibName: nil, bundle: nil)
        self.product = product
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pdpView = PDPView(frame: self.view.frame)
        pdpView.setProductInformations(product: product)
        self.view.addSubview(pdpView)
        self.title = product.title
    }
}
