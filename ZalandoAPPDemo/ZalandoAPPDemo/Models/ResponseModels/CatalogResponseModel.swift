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
    mutating func updateData(result: CatalogResponseModel) {
        self.result.append(contentsOf: result.result)
        self.next = result.next
        self.prev = result.prev
        self.total = result.total
    }
}
