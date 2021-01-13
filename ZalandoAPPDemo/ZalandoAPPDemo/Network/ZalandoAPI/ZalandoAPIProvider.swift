//
//  ZalandoAPIProvider.swift
//  ZalandoAPPDemo
//
//  Created by Umut SERIFLER on 13/01/2021.
//

import Foundation

fileprivate enum ZalandoErrorTypes {
    case noNetwork
    case invalidData
    case unknownError(message: String)
    
    func getError() -> ZalandoErrorResponseModel {
        switch self {
        case .noNetwork:
            return ZalandoErrorResponseModel(message: "No Network")
        case .invalidData:
            return ZalandoErrorResponseModel(message: "Invalid Data")
        case .unknownError(let message):
            return ZalandoErrorResponseModel(message: "\(message)")
        }
    }
}

protocol ZalandoAPIProviderProtocol {
    func genericParser<M>(_ data: Data?, _ response: URLResponse?, _ error: Error?, completionHandler: @escaping (Result<M, ZalandoErrorResponseModel>) -> ()) where M : Decodable
    func getCatalogProducts(completionHandler: @escaping (Result<CatalogResponseModel, ZalandoErrorResponseModel>) -> ())
    func getCategory(completionHandler: @escaping (Result<CategoryResponseModels, ZalandoErrorResponseModel>) -> ())
}


/// Zalando API Provider
struct ZalandoAPIProvider: ZalandoAPIProviderProtocol {
    
    let router = Router<ZalandoAPI>()
    
    /// Generic Parser Method for Decodable formats
    /// - Parameters:
    ///   - data: Taken Data from Model
    ///   - response: URL Response
    ///   - error: Custom Error
    ///   - completionHandler: handler for closure
    /// - Returns: Decodable/Error
    func genericParser<M>(_ data: Data?, _ response: URLResponse?, _ error: Error?, completionHandler: @escaping (Result<M, ZalandoErrorResponseModel>) -> ()) where M : Decodable {
        if error != nil {
            completionHandler(.failure(ZalandoErrorTypes.noNetwork.getError()))
        }
        if let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode {
            guard let responseData = data else {
                completionHandler(.failure(ZalandoErrorTypes.invalidData.getError())) // Data is nil
                return
            }
            do {
                let decodedModel = try JSONDecoder().decode(M.self, from: responseData)
                completionHandler(.success(decodedModel))
            } catch  {
                do {
                    let error = try JSONDecoder().decode(ZalandoErrorResponseModel.self, from: responseData)
                    completionHandler(.failure(error))
                } catch {
                    completionHandler(.failure(ZalandoErrorTypes.invalidData.getError()))
                }
            }
        } else {
            guard let errorData = data else {
                completionHandler(.failure(ZalandoErrorTypes.invalidData.getError()))
                return
            }
            do {
                let error = try JSONDecoder().decode(ZalandoErrorResponseModel.self, from: errorData)
                completionHandler(.failure(error))
            } catch {
                completionHandler(.failure(ZalandoErrorTypes.unknownError(message:"Parse Error").getError()))
            }
            
        }
    }
    
    
    
    /// Get Catalog Products
    /// - Parameter completionHandler: Result<CatalogResponseModel, ZalandoErrorResponseModel>
    /// - Returns: Result<CatalogResponseModel, ZalandoErrorResponseModel>
    func getCatalogProducts(completionHandler: @escaping (Result<CatalogResponseModel, ZalandoErrorResponseModel>) -> ()) {
        router.request(.catalog) { (data, response, error) in
            self.genericParser(data, response, error) { (result) in
                completionHandler(result)
            }
        }
    }
    
    
    /// Get Categories
    /// - Parameter completionHandler: Result<CategoryResponseModels, ZalandoErrorResponseModel>
    /// - Returns: Result<CategoryResponseModels, ZalandoErrorResponseModel>
    func getCategory(completionHandler: @escaping (Result<CategoryResponseModels, ZalandoErrorResponseModel>) -> ()) {
        router.request(.category) { (data, response, error) in
            self.genericParser(data, response, error) { (result) in
                completionHandler(result)
            }
        }
    }
    
    
}
