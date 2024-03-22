//
//  Comment.swift
//  WT2024
//
//  Created by Jorge Silva on 22/03/2024.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let comments = try? JSONDecoder().decode(Comments.self, from: jsonData)

// MARK: - Comment –

struct Comment: Codable, Hashable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case articleId
        case publishedAt = "published-at"
        case name
        case avatar
        case body
    }
    
    let id: String?
    let articleId: String?
    let publishedAt: String?
    let name: String?
    let avatar: String?
    let body: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        self.articleId = try container.decodeIfPresent(String.self, forKey: .articleId) ?? ""
        self.publishedAt = try container.decodeIfPresent(String.self, forKey: .publishedAt) ?? ""
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.avatar = try container.decodeIfPresent(String.self, forKey: .avatar) ?? ""
        self.body = try container.decodeIfPresent(String.self, forKey: .body) ?? ""
    }
}

// MARK: - Comments –

// used to get comments from 2.0
typealias Comments = [Comment]
