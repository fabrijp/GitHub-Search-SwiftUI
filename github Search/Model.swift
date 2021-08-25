//
//  Model.swift
//  github Search
//
//  Created by Alexandre Fabri on 2021/07/23.
//

import Foundation

struct Repository: Codable, Hashable {

    enum CodingKeys: String, CodingKey {
        case htmlUrl = "html_url"
        case fullName = "full_name"
        case language = "language"
        case starGazersCount = "stargazers_count"
    }

    var htmlUrl: String
    var fullName: String
    var language: String?
    var starGazersCount: Int

}

struct Items: Codable {
    var items: [Repository]
    init() {
        items = []
    }
}
