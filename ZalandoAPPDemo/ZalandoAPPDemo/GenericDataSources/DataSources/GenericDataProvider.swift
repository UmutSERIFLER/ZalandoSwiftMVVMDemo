//
//  GenericDataProvider.swift
//  ZalandoAPPDemo
//
//  Created by Umut SERIFLER on 13/01/2021.
//

import UIKit

public protocol GenericDataProvider {
    associatedtype T
    func getHeaderView(in section: Int) -> UIView
    func getHeaderViewHeight(in section: Int) -> Int
    func numberOfSections() -> Int
    func getCellHeight(in section: Int) -> Int
    func numberOfItems(in section: Int) -> Int
    func item(at indexPath: IndexPath) -> T?
    func updateItem(at indexPath: IndexPath, value: T)
}

