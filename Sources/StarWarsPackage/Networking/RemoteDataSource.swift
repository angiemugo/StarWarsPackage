//
//  RemoteDataSource.swift
//  StarWarsExample
//
//  Created by Angie Mugo on 26/07/2021.
//

import RxSwift
import Foundation

public class RemoteDataSource {    
    private let api: APIClientProtocol
    static public let shared = RemoteDataSource()
    
    private init() {
        api = APIClient()
    }
    
    public func starWarsPeople() -> Single<[People]> {
        return getPeople().map { peopleResponse in
            peopleResponse.results.map { person in
                person.toDomainModel()
            }
        }
    }
    
    public func starWarsPlanets() -> Single<[Planets]> {
        return getPlanets().map { planetResponse in
            planetResponse.results.map { planet in
                planet.toDomainModel()
            }
        }
    }
    
    public func starWarsFilms() -> Single<[Films]> {
        return getFilms().map { filmsResponse in
            filmsResponse.results.map { film in
                film.toDomainModel()
            }
        }
    }
    
    func getPeople() -> Single<(PeopleResponse)> {
        let request = URLRequest(.person)
        return api.request(request)
    }
    
    func getPlanets() -> Single<(PlanetResponse)> {
        let request = URLRequest(.planets)
        return api.request(request)
    }
    
    func getFilms() -> Single<(FilmResponse)> {
        let request = URLRequest(.films)
        return api.request(request)
    }
}
