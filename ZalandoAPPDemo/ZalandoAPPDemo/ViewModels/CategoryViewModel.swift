//
//  CategoryViewModel.swift
//  ZalandoAPPDemo
//
//  Created by Umut SERIFLER on 13/01/2021.
//

import Foundation

class CategoryViewModel: ViewModelProtocol {
    var reloadTableViewClosure: (() -> ()) = {}
    var showAlertClosure: ((String?) -> ()) = {_ in}
    
    private(set) var apiService : ZalandoAPIProviderProtocol!
    private(set) var categoryResponse: CatalogResponseModel? {
        didSet {
            self.reloadTableViewClosure()
        }
    }
    
    private(set) var artistName: String?
    
    init(_ artist: CategoryViewModel? = nil,_ apiService: ZalandoAPIProviderProtocol = ZalandoAPIProvider()) {
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
    
    func getProducts(withFilter: String? = nil) -> [Product] {
        guard let filter = withFilter else {
            return self.categoryResponse?.result ?? []
        }
        return (filter == "Clear") ? self.categoryResponse?.result ?? [] : self.categoryResponse?.result.filter({$0.category == filter}) ?? []
    }
}
