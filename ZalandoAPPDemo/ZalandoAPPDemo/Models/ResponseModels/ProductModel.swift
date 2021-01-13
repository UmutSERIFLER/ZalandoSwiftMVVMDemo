//
//  ProductModel.swift
//  ZalandoAPPDemo
//
//  Created by Umut SERIFLER on 13/01/2021.
//

import Foundation

struct Product: Decodable {
    var item_id : String
    var image: String
    var title: String
    var price: Price
    var description: String
    var category: String
}
