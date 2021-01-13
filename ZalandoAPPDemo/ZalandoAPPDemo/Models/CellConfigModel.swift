//
//  CellConfigModel.swift
//  ZalandoAPPDemo
//
//  Created by Umut SERIFLER on 13/01/2021.
//

import UIKit

struct CellConfigModel {
    var cellHeight: Int
    var sectionHeaderHeight: Int
    var sectionHeaderView: UIView
    
    init(cellHeight: Int = 50,sectionHeaderHeight: Int = 50, sectionHeaderView: UIView = UIView()) {
        self.cellHeight = cellHeight
        self.sectionHeaderHeight = sectionHeaderHeight
        self.sectionHeaderView = sectionHeaderView
    }
}
