//
//  CategoryViewModelTest.swift
//  ZalandoAPPDemoTests
//
//  Created by Umut SERIFLER on 13/01/2021.
//

import XCTest
@testable import ZalandoAPPDemo

class CategoryViewModelTest: XCTestCase {

    private var categoryViewModel: CategoryViewModel!
    private var apiService: MockAPIService!

    func testViewModelSuccessExample() throws {
        try self.testViewModel(forStatus: true)
    }
    
    func testViewModelFailExample() throws {
        try self.testViewModel(forStatus: false)
    }
    
    func testViewModel(forStatus: Bool = false) throws {
        let apiService = MockAPIService()
        let catalog = ResourceLoader.catalog
        apiService.categoryResponseModel = ResourceLoader.categories
        apiService.catalogResponseModel = ResourceLoader.catalog
        apiService.testForStatus = forStatus
        apiService.errorResponse = ZalandoErrorResponseModel()
        apiService.getCatalogProducts(for: "") { [weak self] (result) in
            self?.categoryViewModel = CategoryViewModel(catalog)
        }
        XCTAssertEqual(categoryViewModel.categoryResponse?.result.first?.title, catalog?.result.first?.title)
    }

}
