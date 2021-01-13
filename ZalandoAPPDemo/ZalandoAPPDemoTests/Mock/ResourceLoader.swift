//
//  ResourceLoader.swift
//  DeezerAPITests
//
//  Created by Umut SERIFLER on 08/12/2020.
//

import Foundation
@testable import ZalandoAPPDemo

struct ResourceLoader {
    static let categories: CategoryResponseModels? = readFile(named: "categories")
    static let catalog: CatalogResponseModel? = readFile(named: "catalog")
    static func readFile<ModelType: Decodable>(named name: String) -> ModelType?  {
        guard let url = Bundle.main.url(forResource: name, withExtension: "json") else {
            return nil
        }
        
        return try? JSONDecoder().decode(ModelType.self, from: Data(contentsOf: url))

    }
}
