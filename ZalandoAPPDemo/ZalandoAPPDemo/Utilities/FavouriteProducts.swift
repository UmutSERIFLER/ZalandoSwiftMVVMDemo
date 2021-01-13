//
//  FavouriteProducts.swift
//  ZalandoAPPDemo
//
//  Created by Umut SERIFLER on 13/01/2021.
//

import Foundation

struct FavouriteProducts {
    
    static var products : [Product] = []
    
    func addFavourite(product: Product) {
        FavouriteProducts.products.append(product)
    }
    
    func removeFavourite(product: Product) {
        FavouriteProducts.products = FavouriteProducts.products.filter {$0.item_id != product.item_id}
    }
    
    func getProducts() -> [Product] {
        return FavouriteProducts.products
    }
    
    func changeProductStatus(product:Product, isSelected: Bool = false) {
        if isSelected {
            self.addFavourite(product: product)
        }else {
            self.removeFavourite(product: product)
        }
    }
    
    func isProductSelected(id: String) -> Bool {
        return (FavouriteProducts.products.count == 0) ? false : FavouriteProducts.products.contains(where: {$0.item_id == id})
    }

}
