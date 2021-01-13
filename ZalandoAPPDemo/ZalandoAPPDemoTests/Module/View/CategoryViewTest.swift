//
//  CategoryViewTest.swift
//  ZalandoAPPDemoTests
//
//  Created by Umut SERIFLER on 13/01/2021.
//

import XCTest
@testable import ZalandoAPPDemo

class CategoryViewTest: XCTestCase {
    
    func test_productCell() throws {
        let exp = expectation(description: "deinit")
        
        let catalog = ResourceLoader.catalog
        let viewModel = CategoryViewModel(catalog)
        var sut: MockArtistView? = MockArtistView(viewModel: viewModel)
        
        sut?.deinitCalled = {
            exp.fulfill()
        }
        DispatchQueue.global(qos: .background).async {
            sut = nil
        }
        
        waitForExpectations(timeout: 4.0)
    }

}

private class MockArtistView: CategoryViewController {
    var deinitCalled: (() -> Void)?
    deinit { deinitCalled?() }
}
