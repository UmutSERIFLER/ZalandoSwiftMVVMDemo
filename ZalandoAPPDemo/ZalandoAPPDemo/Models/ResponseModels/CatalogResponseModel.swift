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
