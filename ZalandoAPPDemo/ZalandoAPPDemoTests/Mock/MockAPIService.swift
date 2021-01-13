//
//  MockAPIService.swift
//  ZalandoAPPDemoTests
//
//  Created by Umut SERIFLER on 13/01/2021.
//

import Foundation
@testable import ZalandoAPPDemo

final class MockAPIService: ZalandoAPIProviderProtocol {
    
    var testForStatus = false
    var errorResponse: ZalandoErrorResponseModel!
    var catalogResponseModel: CatalogResponseModel!
    var categoryResponseModel: CategoryResponseModels!
    func genericParser<M>(_ data: Data?, _ response: URLResponse?, _ error: Error?, completionHandler: @escaping (Result<M, ZalandoErrorResponseModel>) -> ()) where M : Decodable {
        
    }
    
    func getCatalogProducts(completionHandler: @escaping (Result<CatalogResponseModel, ZalandoErrorResponseModel>) -> ()) {
        if testForStatus {
            completionHandler(.success(catalogResponseModel))
        } else {
            completionHandler(.failure(errorResponse))
        }
    }
    
    func getCategory(completionHandler: @escaping (Result<CategoryResponseModels, ZalandoErrorResponseModel>) -> ()) {
        if testForStatus {
            completionHandler(.success(categoryResponseModel))
        } else {
            completionHandler(.failure(errorResponse))
        }
    }
    
    
}
