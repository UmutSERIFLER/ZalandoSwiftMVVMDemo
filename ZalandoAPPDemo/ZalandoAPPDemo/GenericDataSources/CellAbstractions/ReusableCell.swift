//
//  ReusableCell.swift
//  ZalandoAPPDemo
//
//  Created by Umut SERIFLER on 13/01/2021.
//

import UIKit

public protocol ReusableCell: class  {
    static var reuseIdentifier: String { get }
}

public extension ReusableCell {
    static var reuseIdentifier: String { return String(describing: self) }
}
