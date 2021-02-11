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
    
    init(_ catalog: CatalogResponseModel? = nil,_ apiService: ZalandoAPIProviderProtocol = ZalandoAPIProvider()) {
        self.apiService = apiService
        self.categoryResponse = catalog
    }
    
    func getCategoryProducts(for path: String = "") {
        apiService.getCatalogProducts(for: path) { [weak self] (result) in
            switch result {
            case .success(let result):
                result.result.forEach({print($0.item_id)})
                if self?.categoryResponse == nil {
                    self?.categoryResponse = result
                    return
                }
                self?.categoryResponse?.updateData(result: result)
            case .failure(let error):
                self?.showAlertClosure(error.localizedDescription)
            }
        }
    }
    
    func getProducts(withFilter: String? = nil) -> [Product] {
        guard let filter = withFilter else {
            return self.categoryResponse?.result ?? []
        }
        return (filter == "Clear") ? self.categoryResponse?.result ?? [] : self.categoryResponse?.result.filter({$0.category == filter}) ?? []
    }
    
    func fetchData(indexPath: IndexPath) {
        guard let productCount = self.categoryResponse?.result.count else { return }
        guard let path = self.categoryResponse?.next?.split(separator: "/").last else { return }
        if (productCount < 15) || ((productCount - indexPath.row) == 10) {
            getCategoryProducts(for: String(path))
        }
    }
}
