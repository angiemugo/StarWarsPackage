//
//  URLRequest+StarWars.swift
//  StarWarsExample
//
//  Created by Angie Mugo on 26/07/2021.
//

import Foundation

extension URLRequest {
    init(_ endpoint: APIEndpoint, _ method: APIMethod = .get, _ parameters: [String: Any?]? = nil, _ urlArgs: CVarArg...) {
        let baseURL = URL(string: "https://swapi.dev/")!
        let path = String(format: endpoint.rawValue, urlArgs)
        let urlString = "\(baseURL)\(path)"
        let url = URL(string: urlString)!
        self.init(url: url)
        httpMethod = method.rawValue
    }
}
