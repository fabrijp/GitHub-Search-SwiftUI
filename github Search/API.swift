//
//  API.swift
//  github Search
//
//  Created by Alexandre Fabri on 2021/07/23.
//

import Combine
import Foundation

extension URL {
    static let githubSearchURL: String = "https://api.github.com/search/repositories?"
    static let githubSortParams: String = "&sort=stars&order=desc"
}

class API {

    var cancellables = Set<AnyCancellable>()

    // The error is out of scope for this project. If any error occurs we will return an empty or nil object.
    private func fetch(search: String) -> AnyPublisher<Items, Never>? {

        guard let url = URL(string: URL.githubSearchURL + "q=\(search)" + URL.githubSortParams) else {
            return nil
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Items.self, decoder: JSONDecoder())
            .replaceError(with: Items())
            .eraseToAnyPublisher()

    }

    /**
     Search Request on GitHub
     
     - important: Sends repository search request to GitHub
     - returns: Return the repository array if any
     - parameter search: The query for the search criteria
     - parameter completion: A closure that returns the data object
     
     */
    func request(search: String, _ completion: @escaping (Items) -> Void) {

        let pub = fetch(search: search)
        pub?.sink { items in
            completion(items)
        }
        .store(in: &cancellables)

    }

}
