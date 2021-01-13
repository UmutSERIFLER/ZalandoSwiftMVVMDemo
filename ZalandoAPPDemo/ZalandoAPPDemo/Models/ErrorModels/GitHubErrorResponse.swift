//
//  ZalandoErrorResponseModel.swift
//  ZalandoAPPDemo
//
//  Created by Umut SERIFLER on 13/01/2021.
//

import Foundation

struct ZalandoErrorResponseModel: Decodable, Error {
    var message : String?
}
