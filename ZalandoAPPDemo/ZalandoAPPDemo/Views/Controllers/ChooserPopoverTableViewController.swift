//
//  ChooserPopoverTableViewController.swift
//  ZalandoAPPDemo
//
//  Created by Umut SERIFLER on 13/01/2021.
//

import UIKit

class ChooserPopoverTableViewController: UITableViewController {

    typealias SelectionHandler = (String) -> Void
    
    private var values : [String] = []
    private let onSelect : SelectionHandler?
    
    private(set) var categories: CategoryResponseModels? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.updateTakenData()
            }
        }
    }

    init(onSelect : @escaping  SelectionHandler) {
        self.onSelect = onSelect
        super.init(style: .plain)
        self.tableView.register(FilterOptionTableViewCell.nib, forCellReuseIdentifier: FilterOptionTableViewCell.identifier)
        self.tableView.isScrollEnabled = false
    }
    
    func updateTakenData() {
        guard let result = self.categories?.categories else {
            return
        }
        self.values = result
        self.values.append("Clear")
        self.preferredContentSize = CGSize(width: Int(self.view.frame.width), height: (self.values.count * 40))
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ZalandoAPIProvider().getCategory { (results) in
            switch results {
            case .success(let result):
                self.categories = result
            case .failure:
                DispatchQueue.main.async {
                    self.dismiss(animated: true)
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.values.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let filterCell : FilterOptionTableViewCell = tableView.dequeueReusableCell(withIdentifier: FilterOptionTableViewCell.identifier, for: indexPath) as? FilterOptionTableViewCell {
            filterCell.filterName.text = self.values[indexPath.row]
            return filterCell
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true)
        onSelect?(values[indexPath.row])
    }

}
