//
//  CatalogResponseModel.swift
//  ZalandoAPPDemo
//
//  Created by Umut SERIFLER on 13/01/2021.
//

import Foundation

struct CatalogResponseModel: Decodable {
    var result: [Product]
    var next: String?
    var prev: String?
    var total: Int
}

extension CatalogResponseModel {
    mutating func updateData(result: CatalogResponseModel) -> CatalogResponseModel {
        let products = self.result + result.result
        return CatalogResponseModel(result: products, next: self.next, prev: self.prev, total: self.total)
    }
}
