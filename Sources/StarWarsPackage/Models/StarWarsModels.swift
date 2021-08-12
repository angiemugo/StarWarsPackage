//
//  StarWarsModels.swift
//  StarWarsExample
//
//  Created by Angie Mugo on 26/07/2021.
//

import Foundation

public struct PeopleResponse: Codable {
    public struct Person: Codable {
        let name: String
        let eye_color: String
        
        func toDomainModel() -> People {
            return People(name: name,
                          eyeColor: eye_color)
        }
    }
    let results: [Person]
}

public struct FilmResponse: Codable {
    struct Film: Codable {
        let title: String
        let release_date: String
        let opening_crawl: String
        
        func toDomainModel() -> Films {
            return Films(title: title,
                         openingCrawl: opening_crawl,
                         releaseYear: release_date)
        }
    }
    let results: [Film]
}

public struct PlanetResponse: Codable {
    struct Planet: Codable {
        let name: String
        let population: String
        let climate: String
        
        func toDomainModel() -> Planets {
            return Planets(title: name,
                           population: population,
                           climate: climate)
        }
    }
    let results: [Planet]
}
