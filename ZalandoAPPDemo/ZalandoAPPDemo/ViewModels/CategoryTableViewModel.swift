//
//  CategoryTableViewModel.swift
//  ZalandoAPPDemo
//
//  Created by Umut SERIFLER on 14/01/2021.
//

import Foundation

class CategoryTableViewModel: ViewModelProtocol {
    var reloadTableViewClosure: (() -> ()) = {}
    var showAlertClosure: ((String?) -> ()) = {_ in}
    
    private(set) var apiService : ZalandoAPIProviderProtocol!
    private(set) var categoryResponse: CatalogResponseModel? {
        didSet {
            self.reloadTableViewClosure()
        }
    }
    
    private(set) var artistName: String?
    
    init(_ catalog: CatalogResponseModel? = nil,_ apiService: ZalandoAPIProviderProtocol = ZalandoAPIProvider()) {
        self.apiService = apiService
    }
    
    func getCategoryProducts() {
        apiService.getCatalogProducts { (result) in
            switch result {
                case .success(let result):
                    self.categoryResponse = result
            case .failure(let error):
                self.showAlertClosure(error.localizedDescription)
            }
        }
    }
    
    func getProducts() -> [Product] {
        return self.categoryResponse?.result ?? []
    }
}
