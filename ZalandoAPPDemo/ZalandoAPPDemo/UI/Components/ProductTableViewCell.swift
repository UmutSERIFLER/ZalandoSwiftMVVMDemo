//
//  ProductTableViewCell.swift
//  ZalandoAPPDemo
//
//  Created by Umut SERIFLER on 14/01/2021.
//

import UIKit
import Kingfisher

class ProductTableViewCell: UITableViewCell, ConfigurableCell {
    
    var product: Product? {
        didSet {
            setUpUIWithData()
        }
    }
    
    func configure(_ item: Product, at indexPath: IndexPath) {
        self.product = item
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    fileprivate lazy var productImage : UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    fileprivate lazy var favouriteButton : UIButton = {
        let favButton = UIButton()
        favButton.translatesAutoresizingMaskIntoConstraints = false
        favButton.setImage(UIImage(named: "favourite_deselected_icon"), for: .normal)
        favButton.setImage(UIImage(named: "favourite_selected_icon"), for: .selected)
        favButton.addTarget(self, action: #selector(addRamoveFavbutton), for: .touchUpInside)
        return favButton
    }()
    
    fileprivate lazy var productName : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate lazy var productDescription : UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 8)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate lazy var productPrice : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 8)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    @objc func addRamoveFavbutton() {
        self.favouriteButton.isSelected = !self.favouriteButton.isSelected
        guard let product = self.product else {
            return
        }
        FavouriteProducts().changeProductStatus(product: product, isSelected: self.favouriteButton.isSelected)
    }
    
    func setUpUIWithData() {
        contentView.addSubview(productImage)
        contentView.addSubview(favouriteButton)
        contentView.addSubview(productName)
        contentView.addSubview(productDescription)
        contentView.addSubview(productPrice)
        NSLayoutConstraint.activate([
            productImage.topAnchor.constraint(equalTo: self.topAnchor),
            productImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            productImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            productImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2),
            
            favouriteButton.topAnchor.constraint(equalTo: self.topAnchor),
            favouriteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            favouriteButton.heightAnchor.constraint(equalToConstant: 50),
            favouriteButton.widthAnchor.constraint(equalToConstant: 50),
            
            productName.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 10),
            productName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            productName.topAnchor.constraint(equalTo: self.topAnchor),
            productName.heightAnchor.constraint(equalToConstant: 30),
            
            productDescription.topAnchor.constraint(equalTo: productName.bottomAnchor),
            productDescription.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 10),
            productDescription.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            productDescription.heightAnchor.constraint(equalToConstant: 40),
            
            productPrice.topAnchor.constraint(equalTo: productDescription.bottomAnchor),
            productPrice.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 10),
            productPrice.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            productPrice.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        productName.text = product?.title
        productDescription.text = product?.description
        productPrice.text = product?.price.getFormattedPrice()
        favouriteButton.isSelected = FavouriteProducts().isProductSelected(id: product?.item_id ?? "")
        guard let imageString = product?.image, let imageUrl = URL(string: imageString)  else {
            return
        }
        self.productImage.kf.setImage(with: imageUrl)
    }
    
}

