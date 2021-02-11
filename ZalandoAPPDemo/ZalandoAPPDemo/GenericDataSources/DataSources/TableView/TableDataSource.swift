//
//  TableDataSource.swift
//  ZalandoAPPDemo
//
//  Created by Umut SERIFLER on 13/01/2021.
//

import UIKit

public typealias TableItemSelectionFetchHandlerType = (IndexPath, Bool) -> Void

open class TableDataSource<Provider: GenericDataProvider, Cell: UITableViewCell>:
    NSObject,
    UITableViewDataSource,
    UITableViewDataSourcePrefetching,
    UITableViewDelegate where Cell: ConfigurableCell, Provider.T == Cell.T
{
    
    // MARK: - Delegates
    public var tableItemSelectionFetchHandler: TableItemSelectionFetchHandlerType?
    
    // MARK: - Private Properties
    let provider: Provider
    let tableView: UITableView
    
    // MARK: - Lifecycle
    init(tableView: UITableView, provider: Provider) {
        self.tableView = tableView
        self.provider = provider
        super.init()
        setUp()
    }
    
    func setUp() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.prefetchDataSource = self
        tableView.reloadData()
    }
    
    // MARK: UITableViewDataSource
    public func numberOfSections(in tableView: UITableView) -> Int {
        return provider.numberOfSections()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return provider.numberOfItems(in: section)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
            return UITableViewCell()
        }
        
        if let item = provider.item(at: indexPath) {
            cell.configure(item, at: indexPath)
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let indexPath = indexPaths.first else { return }
        tableItemSelectionFetchHandler?(indexPath, false)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(provider.getCellHeight(in: indexPath.section))
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if provider.numberOfItems(in: section) == 0 { return nil } // Comment line to keep headers in screen
        return provider.getHeaderView(in: section)
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(provider.getHeaderViewHeight(in: section))
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableItemSelectionFetchHandler?(indexPath, true)
    }
    
}
