//
//  ConfigurableCell.swift
//  ZalandoAPPDemo
//
//  Created by Umut SERIFLER on 13/01/2021.
//

import UIKit

public protocol ConfigurableCell: ReusableCell {
    associatedtype T
    func configure(_ item: T, at indexPath: IndexPath)
}
