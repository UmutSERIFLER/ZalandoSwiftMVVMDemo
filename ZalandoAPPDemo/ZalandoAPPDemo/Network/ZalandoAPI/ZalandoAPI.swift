//
//  ZalandoAPI.swift
//  ZalandoAPPDemo
//
//  Created by Umut SERIFLER on 13/01/2021.
//

import Foundation

public enum ZalandoAPI {
    case category
    case catalog(path: String)
}

fileprivate enum ZalandoServiceTitles: String {
    case catalog = "catalog"
    case category = "categories"
}

extension ZalandoAPI: EndPointType {
    
    var baseURL: URL {
        guard let url = URL(string: "https://mobile-code-challenge.s3.eu-central-1.amazonaws.com/") else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .category:
            return ZalandoServiceTitles.category.rawValue
        case .catalog(let path):
            return (path.isEmpty) ? ZalandoServiceTitles.catalog.rawValue : path
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .category, .catalog:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .catalog, .category:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
}
