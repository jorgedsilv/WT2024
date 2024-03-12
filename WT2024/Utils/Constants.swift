//
//  Constants.swift
//  WT2024
//
//  Created by Jorge Silva on 12/03/2024.
//

import Foundation

struct Constants {
    
    // MARK: - URL
    
    static let mobileArticle1_1 = "https://5bb1cd166418d70014071c8e.mockapi.io/mobile/1-1/articles"
    
    static let mobileArticle1_0 = "https://5badefb9a65be000146763a4.mockapi.io/mobile/1-0/articles"
}

// MARK: - Enums

public enum Result<T> {
    case success(T)
    case error(String)
}

public enum NetworkResult<T> {
    case success(T)
    case error(String, (Data?, URLResponse?))
}

public enum HTTPMethod: String, Hashable {
    case GET
    case POST
    case PUT
    case DELETE
}
