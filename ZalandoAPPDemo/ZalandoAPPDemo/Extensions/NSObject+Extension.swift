//
//  NSObject+Extension.swift
//  ZalandoAPPDemo
//
//  Created by Umut SERIFLER on 13/01/2021.
//

import Foundation

extension NSObject {
    class var identifier: String {
        return String(describing: self)
    }
}
