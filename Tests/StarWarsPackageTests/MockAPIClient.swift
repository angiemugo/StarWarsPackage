//
//  MockAPIClient.swift
//  StarWarsSDKTests
//
//  Created by Angie Mugo on 04/08/2021.
//

import Foundation
import RxSwift
import RxCocoa
import StarWarsPackage

enum MockScenarios {
    case timeOut
    case decodeError
    case genericError
}

class MockAPIClient: APIClientProtocol {
    public let localDataSource = JsonLocalDataSource()
    var fetchSuccess = false
    var errorMockScenario = MockScenarios.timeOut
    var endPoint = APIEndpoint.person
    let disposeBag = DisposeBag()

    func getResponse<T: Decodable>() -> Single<T> {
        switch endPoint {
        case .person:
            return localDataSource.read("Person")
        case .films:
            return localDataSource.read("Films")
        case .planets:
            return localDataSource.read("Planets")
        }
    }

    func request<T: Decodable>(_ urlRequest: URLRequest) -> Single<T> {
        return Single.create { single -> Disposable in
            if self.fetchSuccess {
                self.getResponse().subscribe(onSuccess: { item in
                    single(.success(item))
                }, onFailure: { error in
                    single(.failure(error))
                }).disposed(by: self.disposeBag)
                return Disposables.create()
            } else {
                var error = StarWarsError.timeOut
                switch self.errorMockScenario {
                case .decodeError:
                    error = StarWarsError.decodeError
                case .genericError:
                    error = StarWarsError.genericError
                case .timeOut:
                    error = StarWarsError.timeOut
                }
                single(.failure(error))
            }
            return Disposables.create()
        }
    }

func mockWith(_ scenario: MockScenarios) {
    self.errorMockScenario = scenario
}
}
