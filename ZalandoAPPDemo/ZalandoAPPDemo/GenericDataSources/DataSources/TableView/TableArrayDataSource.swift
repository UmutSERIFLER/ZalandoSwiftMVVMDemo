//
//  TableArrayDataSource.swift
//  ZalandoAPPDemo
//
//  Created by Umut SERIFLER on 13/01/2021.
//

import UIKit

open class TableArrayDataSource<T, Cell: UITableViewCell>: TableDataSource<ArrayDataProvider<T>, Cell>
where Cell: ConfigurableCell, Cell.T == T
{
    // MARK: - Lifecycle
    convenience init(tableView: UITableView, array: [T], cellConfig: [CellConfigModel] = []) {
        self.init(tableView: tableView, array: [array], cellConfig: cellConfig)
    }
    
    init(tableView: UITableView, array: [[T]], cellConfig: [CellConfigModel]) {
        let arrayProvider = ArrayDataProvider(array: array, cellConfig: cellConfig)
        super.init(tableView: tableView, provider: arrayProvider)
    }
    
    // MARK: - Public Methods
    public func item(at indexPath: IndexPath) -> T? {
        return provider.item(at: indexPath)
    }
    
    public func updateItem(at indexPath: IndexPath, value: T) {
        provider.updateItem(at: indexPath, value: value)
    }
}
