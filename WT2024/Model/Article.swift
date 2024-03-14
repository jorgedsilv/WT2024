//
//  Article.swift
//  WT2024
//
//  Created by Jorge Silva on 12/03/2024.
//

import Foundation

struct Articles: Codable {
    let items: [Article]
    let count: Int
}

// MARK: - Item
struct Article: Hashable, Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case publishedAt = "published-at"
        case hero
        case author
        case summary
        case body
        case limit
        case page
    }
    
    let id: String?
    let title: String?
    let publishedAt: String?
    let hero: String?
    let author: String?
    let summary: String?
    let body: String?
    let limit: String?
    let page: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.publishedAt = try container.decodeIfPresent(String.self, forKey: .publishedAt) ?? ""
        self.hero = try container.decodeIfPresent(String.self, forKey: .hero) ?? ""
        self.author = try container.decodeIfPresent(String.self, forKey: .author) ?? ""
        self.summary = try container.decodeIfPresent(String.self, forKey: .summary) ?? ""
        self.body = try container.decodeIfPresent(String.self, forKey: .body) ?? ""
        self.limit = try container.decodeIfPresent(String.self, forKey: .limit) ?? ""
        self.page = try container.decodeIfPresent(String.self, forKey: .page) ?? ""
    }
}
