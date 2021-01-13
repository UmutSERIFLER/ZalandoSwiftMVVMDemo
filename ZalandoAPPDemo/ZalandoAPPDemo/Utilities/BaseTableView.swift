//
//  BaseTableView.swift
//  ZalandoAPPDemo
//
//  Created by Umut SERIFLER on 13/01/2021.
//

import UIKit

class BaseTableView: UITableView {
    
    init(_ frame: CGRect = .zero,_ style: UITableView.Style = .grouped,cellArray: [UITableViewCell.Type]){
        super.init(frame: frame, style: .grouped)
        backgroundColor = .white
        tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNormalMagnitude))
        keyboardDismissMode = .onDrag
        cellArray.forEach { register($0, forCellReuseIdentifier: $0.identifier) }
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
}
