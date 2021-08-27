//
//  TestAPIClient.swift
//  StarWarsSDKTests
//
//  Created by Angie Mugo on 04/08/2021.
//

import Foundation
import XCTest
import RxCocoa
import RxSwift
@testable import StarWarsPackage

class TestAPIClient: XCTestCase {
    var SUT: MockAPIClient?
    let disposeBag = DisposeBag()

    override func tearDown() {
        super.tearDown()
        SUT = nil
    }

    override func setUp() {
        super.setUp()
        SUT = MockAPIClient()
    }

    func testGetPeople() {
        SUT?.fetchSuccess = true
        SUT?.endPoint = .person
        let request = URLRequest(.person, .get)
        guard let SUT = SUT else { return }
        let observable: Single<PeopleResponse> = SUT.request(request)
        observable.subscribe { person in
            switch person {
            case .success(let person):
                XCTAssertEqual(person.results[0].name, "Luke Skywalker")
                XCTAssertEqual(person.results[0].eye_color, "blue")
                XCTAssertEqual(person.results.count, 3)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }.disposed(by: disposeBag)
    }

    func testGetFilms() {
        SUT?.fetchSuccess = true
        SUT?.endPoint = .films
        let request = URLRequest(.films, .get)
        guard let SUT = SUT else { return }
        let observable: Single<FilmResponse> = SUT.request(request)
        let openingCrawl = "It is a period of civil war.\r\nRebel spaceships, striking\r\nfrom a hidden base, have won\r\ntheir first victory against\r\nthe evil Galactic Empire.\r\n\r\nDuring the battle, Rebel\r\nspies managed to steal secret\r\nplans to the Empire's\r\nultimate weapon, the DEATH\r\nSTAR, an armored space\r\nstation with enough power\r\nto destroy an entire planet.\r\n\r\nPursued by the Empire's\r\nsinister agents, Princess\r\nLeia races home aboard her\r\nstarship, custodian of the\r\nstolen plans that can save her\r\npeople and restore\r\nfreedom to the galaxy...."
        observable.subscribe { film in
            switch film {
            case .success(let film):
                XCTAssertEqual(film.results[0].opening_crawl, openingCrawl)
                XCTAssertEqual(film.results[0].title, "A New Hope")
                XCTAssertEqual(film.results[0].release_date, "1977-05-25")
                XCTAssertEqual(film.results.count, 2)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }.disposed(by: disposeBag)
    }

    func testGetPlanets() {
        SUT?.fetchSuccess = true
        SUT?.endPoint = .planets
        let request = URLRequest(.planets, .get)
        guard let SUT = SUT else { return }
        let observable: Single<PlanetResponse> = SUT.request(request)
        observable.subscribe { planet in
            switch planet {
            case .success(let planet):
                XCTAssertEqual(planet.results[0].climate, "arid")
                XCTAssertEqual(planet.results[0].population, "200000")
                XCTAssertEqual(planet.results[0].name, "Tatooine")
                XCTAssertEqual(planet.results.count, 2)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }.disposed(by: disposeBag)
    }

    func testGetError() {
        //TODO: Test that the system returns the correct error code
    }

    func testCreateResponse() {
        let endpoint = APIEndpoint.films
        let method = APIMethod.get
        let urlRequest = URLRequest(endpoint, method)
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertNil(urlRequest.httpBody)
        XCTAssertNil(urlRequest.httpBody)
        XCTAssertEqual(urlRequest.url?.absoluteString, "https://swapi.dev/" + APIEndpoint.films.rawValue)
    }
}
