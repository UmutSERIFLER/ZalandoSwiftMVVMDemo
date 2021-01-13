//
//  ViewModelProtocol.swift
//  ZalandoAPPDemo
//
//  Created by Umut SERIFLER on 13/01/2021.
//

import Foundation

protocol ViewModelProtocol {
    var reloadTableViewClosure: (() -> ()) { get }
    var showAlertClosure: ((String?) -> ()) { get }
}


