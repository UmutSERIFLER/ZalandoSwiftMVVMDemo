//
//  PriceModel.swift
//  ZalandoAPPDemo
//
//  Created by Umut SERIFLER on 13/01/2021.
//

import Foundation

struct Price: Decodable {
    var value : Double
    var currency : String
    
    func getFormattedPrice() -> String {
        return "\(currency) \(value)"
    }
}
