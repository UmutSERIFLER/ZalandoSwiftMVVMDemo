//
//  ProductCollectionViewCell.swift
//  ZalandoAPPDemo
//
//  Created by Umut SERIFLER on 13/01/2021.
//

import UIKit
import Kingfisher

class ProductCollectionViewCell: UICollectionViewCell, ConfigurableCell {
    
    func configure(_ item: Product, at indexPath: IndexPath) {
        self.product = item
    }
    
    // Update Model
    var product: Product? {
        didSet {
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
    
    fileprivate lazy var productImage : UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleToFill
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
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(productImage)
        contentView.addSubview(favouriteButton)
        contentView.addSubview(productName)
        contentView.addSubview(productDescription)
        contentView.addSubview(productPrice)
        NSLayoutConstraint.activate([
            productImage.topAnchor.constraint(equalTo: self.topAnchor),
            productImage.widthAnchor.constraint(equalTo: self.widthAnchor),
            productImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            productImage.heightAnchor.constraint(equalToConstant: 225),
            
            favouriteButton.topAnchor.constraint(equalTo: self.topAnchor),
            favouriteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            favouriteButton.heightAnchor.constraint(equalToConstant: 50),
            favouriteButton.widthAnchor.constraint(equalToConstant: 50),
            
            productName.topAnchor.constraint(equalTo: productImage.bottomAnchor),
            productName.widthAnchor.constraint(equalTo: self.widthAnchor),
            productName.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            productName.heightAnchor.constraint(equalToConstant: 25),
            
            productDescription.topAnchor.constraint(equalTo: productName.bottomAnchor),
            productDescription.widthAnchor.constraint(equalTo: self.widthAnchor),
            productDescription.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            productDescription.heightAnchor.constraint(equalToConstant: 25),
            
            productPrice.topAnchor.constraint(equalTo: productDescription.bottomAnchor),
            productPrice.widthAnchor.constraint(equalTo: self.widthAnchor),
            productPrice.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            productPrice.heightAnchor.constraint(equalToConstant: 25)
            
        ])
        
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    @objc func addRamoveFavbutton() {
        self.favouriteButton.isSelected = !self.favouriteButton.isSelected
        guard let product = self.product else {
            return
        }
        FavouriteProducts().changeProductStatus(product: product, isSelected: self.favouriteButton.isSelected)
    }
    
}
